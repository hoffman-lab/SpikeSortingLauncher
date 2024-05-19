# Spike Sorting with Kilosort
Spike Sorting launcher: setup, tutorial, examples, best practice for Hoffman Lab data
	
------------------------------------------------------------------------
This repository will help you get started spike sorting for high resoluton probes like DBC's Deep array probes 64, 128 ch (or Neuropixels probes). 

The software you need and example data are either linked to or reside on the lab's file server https://129.59.231.19:5001  ('/datahome_2/AnalysisTools/SpikeSorting/ `).

------------------------------------------------------------------------

## General Principles you need to know before you start

"One of the most powerful techniques for neuronal population recording is extracellular electrophysiology using microfabricated electrode arrays. Advances in microfabrication have continually increased the number of recording sites available on neural probes, and the number of recordable neurons is further increased by having closely spaced recording sites."

"What is spike sorting? A gold standard in neuroscience is to record extracellularly the activity of single neurons with thin electrodes implanted in the brain. Extracellular recordings pick up the spikes of neurons nearby the electrode tip and the job of the experimenter is to determine which spike corresponds to which neuron. This identification is done based on the shape of the spikes, given that, in principle, each neuron fires spikes of a particular shape, depending on the morphology of its dendritic tree and the distance and orientation relative to the recording site, among other factors. Spike sorting is the grouping of the detected spikes into clusters based on the similarity of their shapes. The resulting clusters of spikes correspond to the activity of different putative neurons. [Spike sorting](https://www.sciencedirect.com/science/article/pii/S0960982211012541)"

"Spike sorting, as currently applied in nearly all labs using extracellular recordings, involves a manual operator. While some labs use a fully manual system, lower error rates can be achieved with a semiautomated process, consisting of four steps. First, spikes are detected, typically by high-pass filtering and thresholding. Second, each spike waveform is summarized by a compact 'feature vector', typically by principal component analysis. Third, these vectors are divided into groups corresponding to putative neurons using cluster analysis. Finally, the results are manually curated to adjust any errors made by automated algorithms. This last step is necessary because although fully automatic spike sorting would be a powerful tool, the output of existing algorithms cannot be accepted without human verification. A similar situation arises in many fields of data-intensive science: in electron microscopic connectomics, for example, automated methods can only be used under the supervision of human operators. [Spike sorting for large, dense electrode arrays](https://www.nature.com/articles/nn.4268)"

Kilosort and several other recently developed spike sorting algorithms use template matching techniques for spike sorting, which operate somewhat differently from traditional methods. These algorithms start by detecting spikes across multiple channels of a neural probe and then identify representative spike waveforms, or templates, for each neuron. During the sorting process, Kilosort continuously compares incoming spikes against these templates using a computationally efficient matching pursuit algorithm. Kilosort sort spikes by fitting spikes to the most similar templates. [Spike sorting with Kilosort - Marius Pachitariu (HHMI)](https://www.youtube.com/watch?v=cmrAhhquC9E&t=9s).


## Physiology of signal and sorting algorithm limitations

## Articles
* [Spike sorting](https://www.cell.com/current-biology/pdf/S0960-9822(11)01254-1.pdf)<br>
* [Spike sorting: new trends and challenges of the era of high-density probes](https://iopscience.iop.org/article/10.1088/2516-1091/ac6b96/meta)<br>
* [Kilosort: realtime spike-sorting for extracellular electrophysiology with hundreds of channels](https://www.biorxiv.org/content/10.1101/061481v1.abstract)<br>
* [Solving the spike sorting problem with Kilosort](https://www.biorxiv.org/content/10.1101/2023.01.07.523036v1.abstract)<br>
* [Spike sorting with Kilosort4](https://www.nature.com/articles/s41592-024-02232-7)<br>
* [A spike sorting toolbox for up to thousands of electrodes validated with ground truth recordings in vitro and in vivo](https://elifesciences.org/articles/34518)<br>
* [How Do Spike Collisions Affect Spike Sorting Performance?](https://www.eneuro.org/content/9/5/ENEURO.0105-22.2022.abstract)<br>


## Tutorials

* Spike sorting with Kilosort - Marius Pachitariu (HHMI): https://www.youtube.com/watch?v=cmrAhhquC9E&t=2s <br>
* Using Phy to curate spike sorting - Nick Steinmetz (UW): https://www.youtube.com/watch?v=N7AsWVk5JVk&t=1783s <br>
* Important spike sorting info: https://edmerix.github.io/SpikeSorting/


## External Resources
* CortexLab: https://github.com/cortex-lab <br>
* Spike sorting benchmark: https://spikeforest.flatironinstitute.org/ <br>
* Unit Quality Metrics: https://allensdk.readthedocs.io/en/latest/_static/examples/nb/ecephys_quality_metrics.html <br>
* Buzcode: https://github.com/buzsakilab/buzcode <br>
* Cell Explorer (Framework for analyzing single cells): https://cellexplorer.org/ <br>
* Bombcell (Curation of electrophysiology spike sorted units): https://github.com/Julie-Fabre/bombcell <br>
* Kilosort instructions on how to manually curate electrophysiological data using Kilosort: https://github.com/singerlabgt/kilosort2-pipeline/blob/master/tutorial/instructions.md <br>
* Kilosort Tools from Mizuseki Lab: https://github.com/Mizuseki-Lab/kilosort-tools/tree/master
* Special Cases and Questions for Kilosort Decisions: https://github.com/singerlabgt/kilosort2-pipeline/blob/master/tutorial/special-cases.md <br>
* Spikeanalysis (Python): https://github.com/zm711/spikeanalysis <br>
* Pynapple (PYthon Neural Analysis Package): https://github.com/pynapple-org/pynapple <br>


## Setup
### Kilosort
Github: https://github.com/cortex-lab/KiloSort <br>
Paper: https://papers.nips.cc/paper_files/paper/2016/hash/1145a30ff80745b56fb0cecf65305017-Abstract.html <br>

Kilosort is a spike sorting algorithm developed for the analysis of extracellular neural recordings. It is designed to identify and separate the activity of individual neurons from the complex signals recorded by electrode arrays in the brain. <br>

Kilosort requires CUDA, a parallel computing platform and programming model developed by NVIDIA for general computing on graphical processing units (GPUs), for optimal performance. On a CUDA-GPU computer, we need to install a compatible CUDA and MATLAB version. Look up your device on the NVIDIA website: https://developer.nvidia.com/cuda-gpus and a compatible MATLAB version here: https://www.mathworks.com/help/parallel-computing/gpu-computing-requirements.html. Lastly, we need to install a C++ compiler for MATLAB. The recommendation is visual studio 2013 community from https://www.visualstudio.com/vs/older-downloads/. Choose the default MATLAB compiler as instcuted here: https://www.mathworks.com/help/matlab/matlab_external/choose-c-or-c-compilers.html.

After these steps, follow the installation guide on the Kilosort github page to install it.


### Phy
Github: https://github.com/cortex-lab/phy <br>

phy is an open-source Python library providing a graphical user interface for visualization and manual curation of large-scale electrophysiological data. It is optimized for high-density multielectrode arrays containing hundreds to thousands of recording sites. <br>

To install phy, we first need to install python. I suggest installing anaconda which is a distribution of the Python programming language for scientific computing. Download and install Anaconda from here: https://www.anaconda.com/download. When/if asked whether to setup Anaconda path to environment variable, choose yes. Open Anaconda prompt, and follow instructions on the Phy github page to install the package.

> [!WARNING]
> I have noticed that Python 12 is not compatible with the latest version of Phy (2.05). Install or change Python version to 11.0 for full functionality.

> [!WARNING]
> You should install KlustaKwik if you intend to use phy plugins.
```python
pip install klusta klustakwik2
```


### Phy Plugins
Github: https://github.com/petersenpeter/phy2-plugins <br>

Phy plugins are a number of added features to the basic Phy functionality. The most important one is reclustering with Klusta which allows you to perform clustering on the Kilosort output in Phy.

## Preprocessing data for Spike Sorting

Preprocessing comprises formatting data into Kilosort compatible format (binary files) and cleaning the data (e.g. removing common noise across channels). Kilosort can read a single binary file (e.g. .dat with specific precisions e.g. 16bit) which contains all channels and data points in [channel by timepoint] structure. If the data is already Kilosort compatible, conversions are not required. <br>

If the recorded data has shared artifacts across the channels, sometimes Common Average Referencing can be used to remove noise. Common Average Referencing (CAR) is a signal processing technique used in spike sorting to improve the quality of neural recordings by reducing noise. In CAR, the mean signal from all recording channels of a neural probe is calculated and then subtracted from each individual channel. This process helps to remove common noise sources, such as electrical interference and movement artifacts, that affect all channels similarly. By doing so, CAR enhances the signal-to-noise ratio, making it easier to detect and accurately sort spikes from individual neurons. This technique is particularly useful in high-density recordings where common noise can significantly impact the quality of the recorded data. <br>

Matlab code for running CAR on binary data: https://github.com/cortex-lab/spikes/blob/master/preprocessing/applyCARtoDat.m


### Conversion Instructions for Neuralynx/Freelynx systems
In Perpl lab, we use Neurolynx/freelynx for our wireless recordings in the lab. The primary file format used by Neuralynx is (CSC) which store continuous, raw electrophysiological data. Each CSC file corresponds to a single channel of data and includes time-stamped voltage measurements recorded from the neural probe. To spike sort the data with Kilosort, we need to create a binary file (convert our data from Neuralynx .ncs files to a single .dat file). To understand the conversion process, you need to know about what binary files are? What is the precision of a binary file? What is bitVolt? <br>

<details>

<summary>Binary Files</summary>

# What is a Binary File?

A binary file is a type of computer file that contains data in a format that is not human-readable but is meant to be interpreted by a computer program. Unlike text files, which store data in a sequence of characters that can be read as text, binary files store data in a sequence of bytes that represent binary data, such as numbers, images, audio, or any other type of raw data.

## Characteristics of Binary Files
**Format:** Binary files can contain any type of data, encoded in binary form. This could include integers, floating-point numbers, characters, and more. <br>
**Efficiency:** They are typically more compact and efficient for storing large amounts of data because they store the raw byte representations without the need for conversion to and from text. <br>
**Specific Use:** Often used for applications requiring precise data representation, such as executable programs, images, audio files, and scientific data.

# Precision of a Binary File
The precision of a binary file refers to how accurately the data is represented within the file. It is determined by the following factors:

Data Type and Bit Depth: The type of data and the number of bits used to represent each unit of data (e.g., 8-bit, 16-bit, 32-bit, 64-bit) significantly affect precision.

**Integer Precision:** For integers, precision depends on the bit depth. A 16-bit integer can represent 65,536 different values, while a 32-bit integer can represent over 4 billion values.
Floating-Point Precision: For floating-point numbers, precision depends on the format (e.g., single precision, double precision). Single precision (32-bit) and double precision (64-bit) formats differ in how many significant digits they can represent and their range. <br>
**File Structure:** The way data is organized in the binary file also impacts precision. For example, storing time-series data with a higher sampling rate increases temporal precision.

Encoding and Representation: The method used to encode data in the file (e.g., IEEE 754 for floating-point numbers) also affects precision.

# Practical Examples
**Electrophysiological Data:** In electrophysiological recordings, the precision of the data stored in binary files is crucial. For instance, the voltage values recorded from neurons may be stored as 16-bit or 24-bit integers, affecting how finely the voltages can be distinguished. <br>

**Image Files:** For image files, precision can refer to color depth. An 8-bit image can represent 256 different colors per channel, while a 24-bit image can represent over 16 million colors.

# Summary
A binary file stores data in a binary format, which is efficient and capable of representing various types of data accurately. The precision of a binary file is determined by the data type, bit depth, file structure, and encoding method, all of which define how accurately the data is represented and stored. This precision is crucial in applications requiring high data fidelity, such as scientific computing, image processing, and audio recording.

</details>


<details>

<summary>Bitvolt and Precision</summary>

The term "bitvolt" in electrophysiological recordings refers to the voltage representation of one bit of the analog-to-digital converter (ADC) used in the recording system. It indicates the smallest voltage difference that can be distinguished by the ADC and is crucial for understanding the precision of the recorded signals.

**Bit Resolution:** The precision of an electrophysiological recording system is largely determined by the bit resolution of the ADC. Common bit resolutions are 12-bit, 16-bit, and 24-bit. Higher bit resolutions allow for more precise measurements of the signal voltage.

**Voltage Range:** The total voltage range of the ADC, often referred to as the input range, is the maximum range of voltages that the ADC can convert into digital values. This range is divided into discrete steps determined by the bit resolution.

**Calculation of Bitvolt:**
```math
\text{Bitvolt} = \frac{\text{Voltage Range}}{2^{\text{Bit Resolution}}}
```

For example, if the voltage range is ±5V (10V total) and the ADC is 16-bit, the bitvolt would be:

```math
\text{Bitvolt} = \frac{10 \text{ V}}{2^{16}} = \frac{10}{65536} \approx 0.0001526 \text{ V} = 152.6 \text{ µV}
```

**Precision:** The smaller the bitvolt value, the higher the precision of the recording system. This means the system can detect smaller changes in voltage, leading to more detailed and accurate recordings of electrophysiological signals.

Practical Implications
* Noise: Lower bitvolt values help in distinguishing the actual neural signals from background noise, improving the signal-to-noise ratio (SNR).
* Signal Detail: Higher precision allows for better discrimination of subtle features in the neural signals, which is critical for accurate spike sorting and other analyses.
* Dynamic Range: Systems with higher bit resolution can capture both very small and very large voltage changes, providing a broader dynamic range and reducing the likelihood of signal clipping.

In summary, the bitvolt is a key parameter that determines the precision of electrophysiological recordings. It relates directly to the bit resolution and the voltage range of the recording system, with smaller bitvolt values indicating higher precision and more detailed signal representation.


</details>

I wrote a MATLAB script for converting .csc files to a single .dat file ( `perpl_NLX2Binary`). By default, I change the bitVolts to 0.195 because this is more commonly used in intan/openephys systems and allows for easier concatenation of files. Note that for concatenation, all files MUST have the same bitVolt. The script requires NLX Mex files.

You can download NLX to MATLAB Import/Export MEX Files from [here](https://github.com/vandermeerlab/vandermeerlab/tree/master/code-matlab/shared/io/neuralynx) <br>


### OpenEphys
New versions of OpenEphys allow for storing the data directly in [binary formats (.dat)](https://open-ephys.github.io/gui-docs/User-Manual/Recording-data/Binary-format.html). So unless you need to change the bitVolts or truncate the data, you don't have to run conversions on OpenEphys files for Kilosort spike sorting.


### View binary data
NeuroScope is an advanced viewer for neurophysiological and behavioral data: it can display local field potentials (LFPs), neuronal spikes, and behavioral events. It also features limited editing capabilities.

Download: https://neurosuite.sourceforge.net/


## Getting started with example data

### Edit the config file with desired parameters
In Kilosort, a config file refers to a configuration script or parameters file for defining the parameters and settings used during the spike sorting process. This file allows users to customize various aspects of Kilosort's operation to suit specific datasets or experimental conditions. 

[Overview of how KiloSort uses the settings](https://github.com/cortex-lab/KiloSort/wiki/Config-Variables)

Some of these parameters have not been explained on the above github page. I will try to best explain them here:


<details>

<summary>**initialize**</summary>

In Kilosort, the initialize parameter determins how the algorithm starts the sorting process, which can impact the efficiency and accuracy of the final spike sorting results. Here’s a closer look at the options available for the initialize parameter in Kilosort and what they signify:

'fromData': When set to 'fromData', Kilosort initializes the sorting process by using the actual recorded data to form initial clusters or templates. This involves detecting spikes in the raw data, grouping them based on their shapes and amplitudes, and forming initial templates. This method is data-driven and can adapt well to the specific characteristics of the dataset.

'no': Setting the initialize parameter to 'no' means that Kilosort will not perform any initial clustering based on the raw data. Instead, it relies on a different approach using default provided templates, to start the sorting process. This option might be used in scenarios where there is prior knowledge about the spike shapes or when re-sorting data using previously validated templates.

The choice of initialization method can depend on several factors, including the quality of the recording, the expected variability of spike shapes, and specific research needs. Proper initialization can significantly enhance the sorting quality by accurately capturing the diverse spike waveforms present in the data, which are critical for reliable neuron identification and activity analysis.

</details>



<details>

<summary>**Thresholds**</summary>

Kilosort 1 requires threshold values for several steps of the spike sorting which sometimes can be confusing. Here's a list:

**spkTh - Threshold for Identifying Spikes to Make Templates**
If initialize='fromData', KiloSort uses this threshold to identify a set of sample waveforms, these are then projected onto the PCs and are clustered using k-means. Each cluster is used to generate a 'template', this becomes the set of initialisation templates that KiloSort subsequently uses.

**Th - Threshold for Comparing Spike to Template**
KiloSort projects a candidate spike waveform onto each template to assess how much of the variance of that spike in the waveform can be explained by the template. This threshold allows sets how much of the variance needs to be explained to consider the waveform part of the template. In other words, the threshold is for how much variance is allowed around the template, a small value indicates a large amount of variance is allowed - allowing this template's cluster to accumulate more waveforms that vary from the template. There are 3 elements. The first 2 elements are used to create a linspace() between anneal 1 and the anneal final (nannealpasses*NBatch). e.g. 1 and 5 for 10 anneals: linspace(1,5,10). This effectively creates an increasingly harder threshold to cross for each anneal pass. The final element is used during the final template matching pass - i.e. the pass that goes through each batch sequentially and performs parallel matching.


**lam - Penalty for Amplitudes Different to the Template**
A large value of lam means that if the template needs to be scaled to match the candidate waveform, there is a large penalty associated with that. The penalty is referring to the value of similarity between the waveform and the template, hence a large penalty will cause a reduction in the similarity value. The threshold for similarity is set by Th.

</details>



<details>

<summary>**Nfilt - Starting Number of Clusters**</summary>

The core algorithm of Kilosort 1 clustering is scaled k-means. K-means clustering requires an estimate of the number of clusters for the initial clustering.

Nfilt sets the target number of clusters to find. This mean the output (before any auto-merging) will usually have this many clusters, but if shuffle_clusters = 1, you may find the final number of clusters deviates from this value. Typically you want this variable to be 4-8 times the number of recording sites (i.e. channels, Nchan) you have. However, the lower the input impedance of your recording sites, the lower you can set this value. A low input impedance indicates that you will still receive large amplitude signals relatively further away from the recording site, hence if all your recording sites were low impedance you might find that they essentially record the same signal - KiloSort will therefore not be able to cluster signals base on a waveform signature that spans multiple channels.

</details>


### Generate a channel map file for your probe
A channel map in Kilosort refers to a configuration that defines the layout of electrodes used in the recording. Creating an accurate channel map is essential for effective data analysis in Kilosort, as it directly influences the quality of spike detection and sorting results. Channel map is a .mat file which includes several types of information saved in matlab variables.

1. **chanMap** and **chanMap0ind**: The channel map specifies the physical arrangement of the electrodes in the recording device. This is crucial because the spatial relationships between electrodes can affect the sorting algorithms' ability to accurately attribute spikes to specific neurons. In some setups, not all channels of a recording device may be used, or there might be a need to reorder them according to specific experimental designs. The channel map allows users to define active channels and possibly ignore others that are not used or are noisy.
The difference between chanMap and chanMap0ind is in indexing. Matlab starts indexing from 1 and Python from 0.

3. **Geometry Information**: The xcoords and ycoords variables include the x and y coordinates of each electrode, which helps the phy visualization software to understand which electrodes are close to each other. These variables are for visualization only and shouldn't affect the results of the spike sorting.

4. **connected**: This logical variable indicates which channels must be used for spike sorting. In cases where you'd like to exclude some channels to due high level of noise, or would like to run a partial spike sorting on some but not all channels you can modify this variable. To include channels, assign logical value True (or 1) to the corresponding channel index.

5. **kcoords**: This variable stores the shank number. This is useful in cases where you have simultaneous recordings using multiple probes and stored all of the files in 1 file but they are in different brain areas so their spike sorting must be separate. You can assign differen numerical values to groups of channels that coorespond to each single probe.

6. **name** and **fs**: name species the name of the channel map you chose for your file and fs is the sampling frequency of your recording.





## Known issues about Kilosort 1 clustering

### Spike holes
[Spike holes: Spikes within the batching edges are not detected #594](https://github.com/MouseLand/Kilosort/issues/594)

### Double-counted spikes
[Double-counted spikes](https://github.com/MouseLand/Kilosort/issues/29)

Kilosort begins by detecting potential spikes from the raw data and forming initial templates, which are average waveforms representing common spike shapes detected across the channels. Detected spikes are assigned to the most similar template based on their shapes and amplitudes. After spikes are detected and assigned to templates, Kilosort calculates the residual signal. This residual is obtained by subtracting the contributions of the detected spikes (as represented by the templates) from the original data. Essentially, the residual signal represents what is left of the data after removing the parts that have been accounted for by the currently identified spikes and their templates. Kilosort then processes the residual signal to detect additional spikes. This step is crucial because some spikes may initially be obscured by larger, overlapping spikes. By removing the influence of the already detected spikes, the algorithm can more clearly see other spikes that were previously hidden in the noise or masked by dominant spikes. The process of assigning spikes to templates, calculating the residual, and detecting new spikes in the residual signal is repeated iteratively. With each iteration, the templates are updated to better fit the spikes assigned to them, and the residual is recalculated to reflect the most recent subtractions. By repeatedly updating the templates and recalculating the residuals, Kilosort ensures that even spikes that are temporally overlapping or of lower amplitude are detected and correctly attributed. This iterative refinement helps in minimizing the noise and improving the overall accuracy of the spike sorting process. Residual subtraction is thus a powerful technique in the Kilosort algorithm that enhances its ability to accurately sort spikes by continuously refining the signal representation. This method is particularly beneficial in dense, high-channel-count recordings where neuronal spikes frequently overlap, making traditional spike detection methods less effective.

However, this method comes with its own drawbacks. In situation where the recording contains very large spikes, a residual after template subtraction can be detected again as a separate cluster. This results in double counting the same spikes. In cases when this happens, it is easy to check for it in the crosscorrelograms (CCGs). The CCGs would show a large peak at 0 latency.

I modified a code from Adrian Bondy ('remove_ks1_duplicate_spikes') that takes the kilosort2 output rez and identifies pair of spikes that are close together in time and space.


### Over-merging
[ops.splitT and ops.mergeT and other parameters #68](https://github.com/cortex-lab/KiloSort/issues/68)

After initiaial clustering, Kilosort runs a posthoc merging algorithm ('merge_posthoc2') to group clusters that are similar. I wouldn't recommend the use of this algorithm. I deactivated it in my pipeline. Although, it will add more work to the manual clustering part, it worth the effort.

### Classifying complex spikes into multiple clusters
[Electrophysiological characteristics of hippocampal complex-spike cells and theta cells](https://link.springer.com/article/10.1007/BF00238898)

Complex spikes are spontaneous bursts of about 2-10 action potentials of decreasing amplitude and increasing duration recorded extracellularly, with very short interspike intervals. The decreasing amplitude nature of complex spikes make them a difficult case for spike sorting algorithms that work solely based on waveform. Sometimes, the smaller amplitude spikes during a complex spike which is emitted by a single cell are classified incorrectly into multiple clusters. Such cases can be identified using assymetric CCGs between clusters of the same channel and also viewing example spikes on the phy trace view. The rate of this error in clustering will depend on the parameters of the spike sorting especially lam and Th. It is always best to have stringent criteria and merge posthoc.


### Noisy clusters
[Noisy clusters #80](https://github.com/cortex-lab/KiloSort/issues/80)

### Missing spikes #160
[Missing spikes #160](https://github.com/cortex-lab/KiloSort/issues/160)







