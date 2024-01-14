function perpl_NLX2Binary(filedir, outputdir, probeName, varargin)


% issues to fix:
    % check if the file already exists

p = inputParser;
addParameter(p,'ChannelVec',[1 64 64],@isvector)           
addParameter(p,'TimeUnit','s',@isstring)           
addParameter(p,'AmplitudeUnit','uV',@isstring)
addParameter(p,'bitVolts',0.195,@isfloat)
addParameter(p,'suffix', '_Raw.dat',@ischar)
addParameter(p,'sample_window', [])
parse(p,varargin{:})

startchan       = p.Results.ChannelVec(1);
channelNum      = p.Results.ChannelVec(2);
nChannels       = p.Results.ChannelVec(3);
TimeUnit        = p.Results.TimeUnit;
AmplitudeUnit   = p.Results.AmplitudeUnit;
bitVolts        = p.Results.bitVolts;
suffix          = p.Results.suffix;
sample_window   = p.Results.sample_window;

%%
if strcmp(TimeUnit, 'ms')
    TimeConvFactor = 10^-6 * 1000;  %ms
else strcmp(TimeUnit, 's')
    TimeConvFactor = 10^-6;  %s
end

if strcmp(AmplitudeUnit, 'V')
    VoltageConvFactor = 1;
elseif strcmp(AmplitudeUnit, 'mV')
    VoltageConvFactor = 1000;
elseif strcmp(AmplitudeUnit, 'uV')
    VoltageConvFactor = 10^6;
elseif strcmp(AmplitudeUnit, 'ADbits')
    VoltageConvFactor = 0;
else
    error('Input voltage conversion factor is not a valid value.')
end

%%
fid = fopen(fullfile(outputdir, [probeName, 'klusta_continous.dat']), 'w');

for CSC = startchan:channelNum
    
    fprintf(['Be Patient Processing CSC', num2str(CSC), '... \n'])
    
    % load raw data
%     filename = fullfile(filedir, [channel{CSC} '.ncs']);
    filename = fullfile(filedir, [probeName num2str(CSC) '.ncs']);

    [Timestamps, ~, SampleFrequencies, NumberOfValidSamples, Samples, Header] = Nlx2MatCSC(filename, [1 1 1 1 1], 1, 1, []);

    % disabled channels cannot be loaded
    if Timestamps == 0
        error(['No csc data (disabled tetrode channel). Consider deleting ',channel,'.']);
    end
    
    % check for each data
    % check for constant sampling frequency
    Fs = unique(SampleFrequencies);
    if length(Fs) ~= 1
        warning('More than one sampling frequency found!');
    end
    
    % extract information from header
    hdr.ADBitVolts = Header{cellfun(@(x) ~isempty(x),strfind(Header,'-ADBitVolts '))};
    hdr.ADBitVolts = strsplit(hdr.ADBitVolts, ' ');
    
    % convert units
    Timestamps = Timestamps .* TimeConvFactor;
    if VoltageConvFactor ~= 0
        Samples = Samples .* VoltageConvFactor .* str2num(hdr.ADBitVolts{1, 2});
    end
    
    % construct within-block tvec
    nSamplesPerBlock = size(Samples,1);
    block_tvec = 0:1./Fs:(nSamplesPerBlock-1)./Fs;
    
    data = nan(numel(Samples), 1); % allocate memory and then fill; can trim later
    tvec = nan(numel(Samples), 1);

    idx = 1; % move this along as we go through the loop over all samples
    
    nBlocks = length(Timestamps);
    badBlocks = zeros([1, channelNum]); % counter

    for iB = 1:nBlocks
        nvs = NumberOfValidSamples(iB);
        if nvs ~= 512, badBlocks(CSC) = badBlocks(CSC) + 1; end
        
        data(idx:idx+nvs-1) = Samples(1:nvs,iB);
        tvec(idx:idx+nvs-1) = block_tvec(1:nvs)+Timestamps(iB);
        
        idx = idx + nvs;
    end % of block loop
    
    
    data2 = data(~isnan(data)); %data = filtfilt(b, a, data);
    data2 = data2/bitVolts;
    
    if length(unique(badBlocks)) > 2
        warning('bad blocks of signal are not consistent across channels.')
        fclose(fid);
    end
    
    if ~isempty(sample_window)
        data2 = data2(sample_window(1):sample_window(2));
    end

    fwrite(fid, data2, 'int16');
    
    if CSC == channelNum
        timestamps = tvec(~isnan(data));
        
        if ~isempty(sample_window)
            timestamps = timestamps(sample_window(1):sample_window(2));
        end
        
        if ~isequal(numel(timestamps), numel(data2)); error('Inconsistent sample numbers.'); end
        save(fullfile(outputdir, 'timestamps.mat'), 'timestamps', '-v7.3')
    end
    
end

fclose(fid);

%% Transpose
% filename = fullfile(outputdir, [probeName, 'klusta_continous.dat']);
% chunkSize = 1e6;
% fid = []; fidOut = [];
% d = dir(filename);
% nSampsTotal = d.bytes/nChannels/2;
% nChunksTotal = ceil(nSampsTotal/chunkSize);
% 
% try
%     fid = fopen(filename, 'r');
%     fidOut = fopen(fullfile(outputdir, [probeName, 'kilosort_continous.dat']), 'w');
%     
%     chunkInd = 1;
%     while 1
%         fprintf(1, 'chunk %d/%d\n', chunkInd, nChunksTotal);
% %         dat = fread(fid, [nChannels chunkSize], '*int16'); %dat = dat';
%         dat = fread(fid, nChannels*chunkSize, '*int16');
%         dat = reshape(dat, [], nChannels)';
%         if ~isempty(dat)
%             fwrite(fidOut, dat, 'int16');
%         else
%             break
%         end
%         chunkInd = chunkInd+1;
%     end
%     fclose(fid);
%     fclose(fidOut);
% catch me
%     if ~isempty(fid)
%         fclose(fid);
%     end
%     if ~isempty(fidOut)
%         fclose(fidOut);
%     end
%     rethrow(me)
% end


filename = fullfile(outputdir, [probeName, 'klusta_continous.dat']);
d = dir(filename);
nSamples = d.bytes/nChannels/2;
m = memmapfile(filename,...
               'Format',{'int16',[nSamples, nChannels],'lfp'});

fidOut = fopen(fullfile(outputdir, [probeName, suffix]), 'w');

Batch = floor(length(m.Data.lfp)/1e6);
Starts = 1:1e6:length(m.Data.lfp);
for ii = 1:Batch+1
    if ii < Batch + 1
        tmp = m.Data.lfp(Starts(ii):Starts(ii+1)-1, :); tmp = tmp';
    elseif ii == Batch + 1
        tmp = m.Data.lfp(Starts(ii):end, :); tmp = tmp';
    end
    fwrite(fidOut, tmp, 'int16');
end
fclose(fidOut);

clear m
filename = fullfile(outputdir, [probeName, 'klusta_continous.dat']);
delete(filename)
end


%%

% nChannels = 128;
% filename = 'klusta_continous.dat'
% d = dir(filename);
% nSamples = d.bytes/nChannels/2;
% m = memmapfile(filename,...
%                'Format',{'int16',[nChannels, nSamples],'lfp'});  




% % Transpose for Kilosort [nchannels * timestamps]
% fid = fopen('klusta_continous.dat', 'r');
% fidOut = fopen('kilosort_continous.dat', 'w');
% 
% nChansTotal = length(channel); d = dir('klusta_continous.dat'); nSampsTotal = d.bytes/nChansTotal/2;
% chunkSize = 1000000;
% 
% chunkInd = 1;
% while 1
%     dat = fread(fid, [chunkSize nChansTotal], 'int16');
%     dat = dat';
%     if ~isempty(dat)
%       fwrite(fidOut, dat, 'int16');
%     else
%       break
%     end
%     
%     chunkInd = chunkInd+1;
% end
% 
% fclose(fid); fclose(fidOut);

% nChannels = channelNum;



