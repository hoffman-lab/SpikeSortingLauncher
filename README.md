# Spike sorting with Kilosort
Spike sorting launcher: setup, tutorial, examples, best practice for Hoffman Lab and other high-density neural data
	
------------------------------------------------------------------------
This repository will help you get started spike sorting with high resolution probes (e.g. Diagnostic Biochip's Deep Array probes, Neuropixels probes, or others). 

For the official tutorial, the software you need and example data are on the DBC cloud storage/server.

------------------------------------------------------------------------

## General principles, before you start

"What is spike sorting? A gold standard in neuroscience is to record extracellularly the activity of single neurons with thin electrodes implanted in the brain. Extracellular recordings pick up the spikes of neurons nearby the electrode tip and the job of the experimenter is to determine which spike corresponds to which neuron. This identification is done based on the shape of the spikes, given that, in principle, each neuron fies spikes of a particular shape, depending on the morphology of its dendritic tree and the distance and orientation relative to the recording site, among other factors. Spike sorting is the grouping of the detected spikes into clusters based on the similarity of their shapes. The resulting clusters of spikes correspond to the activity of different putative neurons. [Spike sorting](https://www.sciencedirect.com/science/article/pii/S0960982211012541)"

"Spike sorting, as currently applied in nearly all labs using extracellular recordings, involves a manual operator. While some labs use a fully manual system, lower error rates can be achieved with a semiautomated process, consisting of four steps. First, spikes are detected, typically by high-pass filtering and thresholding. Second, each spike waveform is summarized by a compact 'feature vector', typically by principal component analysis. Third, these vectors are divided into groups corresponding to putative neurons using cluster analysis. Finally, the results are manually curated to adjust any errors made by automated algorithms. This last step is necessary because although fully automatic spike sorting would be a powerful tool, the output of existing algorithms cannot be accepted without human verification. A similar situation arises in many fields of data-intensive science: in electron microscopic connectomics, for example, automated methods can only be used under the supervision of human operators. [Spike sorting for large, dense electrode arrays](https://www.nature.com/articles/nn.4268)"

Kilosort and several other recently developed spike sorting algorithms use template matching techniques for spike sorting, which operate somewhat differently from traditional methods. These algorithms start by detecting spikes across multiple channels of a neural probe and then identify representative spike waveforms, or templates, for each neuron. During the sorting process, Kilosort continuously compares incoming spikes against these templates using a computationally efficient matching pursuit algorithm. Kilosort sort spikes by fitting spikes to the most similar templates. [Spike sorting with Kilosort - Marius Pachitariu (HHMI)](https://www.youtube.com/watch?v=cmrAhhquC9E&t=9s).


## Physiological basis and sorting algorithm limitations

"One of the most powerful techniques for neuronal population recording is extracellular electrophysiology using microfabricated electrode arrays. Advances in microfabrication have continually increased the number of recording sites available on neural probes, and the number of recordable neurons is further increased by having closely spaced recording sites." Waveforms on >=3 sites per unit is recommended for this discussion. 

![CellsPerSiteSorted_Gelinas](https://github.com/user-attachments/assets/497e5891-adc6-4178-a903-fd9d6a1553db)


### Key Reading
* [Spike sorting](https://www.cell.com/current-biology/pdf/S0960-9822(11)01254-1.pdf)<br>
* [Chapter 1 - Spike Sorting](https://neurophysics.ucsd.edu/publications/obd_ch3_2.pdf)<br>
* [Spike sorting: new trends and challenges of the era of high-density probes](https://iopscience.iop.org/article/10.1088/2516-1091/ac6b96/meta)<br>
* [Kilosort: realtime spike-sorting for extracellular electrophysiology with hundreds of channels](https://www.biorxiv.org/content/10.1101/061481v1.abstract)<br>
* [Solving the spike sorting problem with Kilosort](https://www.biorxiv.org/content/10.1101/2023.01.07.523036v1.abstract)<br>
* [Spike sorting with Kilosort4](https://www.nature.com/articles/s41592-024-02232-7)<br>
*refer to Further Reading below*

### Tutorials

* Spike sorting with Kilosort - Marius Pachitariu (HHMI): https://www.youtube.com/watch?v=cmrAhhquC9E&t=2s <br>
* Using Phy to curate spike sorting - Nick Steinmetz (UW): https://www.youtube.com/watch?v=N7AsWVk5JVk&t=1783s <br>
* Important spike sorting info: https://edmerix.github.io/SpikeSorting/ <br>


### External Resources
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

## Preprocessing data for spike sorting

Preprocessing comprises formatting data into Kilosort compatible format (binary files) and cleaning the data (e.g. removing common noise across channels). Kilosort can read a single binary file (e.g. .dat with specific precisions e.g. 16bit) which contains all channels and data points in [channel by timepoint] structure. If the data are already Kilosort compatible, conversions are not required. <br>

If the recorded data has shared artifacts across the channels, sometimes Common Average Referencing can be used to remove noise. Common Average Referencing (CAR) is a signal processing technique used in spike sorting to improve the quality of neural recordings by reducing noise. In CAR, the mean signal from all recording channels of a neural probe is calculated and then subtracted from each individual channel. This process helps to remove common noise sources, such as electrical interference and movement artifacts, that affect all channels similarly. By doing so, CAR enhances the signal-to-noise ratio, making it easier to detect and accurately sort spikes from individual neurons. This technique is particularly useful in high-density recordings where common noise can significantly impact the quality of the recorded data. <br>

Matlab code for running CAR on binary data: https://github.com/cortex-lab/spikes/blob/master/preprocessing/applyCARtoDat.m


### Conversion Instructions for Neuralynx/Freelynx Systems
In the Hoffman lab, we use Neuralynx/Freelynx for our wireless recordings in the lab. The primary file format used by Neuralynx is (CSC) which store continuous, raw electrophysiological data. Each CSC file corresponds to a single channel of data and includes time-stamped voltage measurements recorded from the neural probe. To spike sort the data with Kilosort, we need to create a binary file (convert our data from Neuralynx .ncs files to a single .dat file). To understand the conversion process, you need to know what binary files are, the precision of a binary file, and what a bitVolt is. <br>

<details>

<summary>Binary Files</summary>

## What is a Binary File?

A binary file is a type of computer file that contains data in a format that is not human-readable but is meant to be interpreted by a computer program. Unlike text files, which store data in a sequence of characters that can be read as text, binary files store data in a sequence of bytes that represent binary data, such as numbers, images, audio, or any other type of raw data.

### Characteristics of Binary Files
**Format:** Binary files can contain any type of data, encoded in binary form. This could include integers, floating-point numbers, characters, and more. <br>
**Efficiency:** They are typically more compact and efficient for storing large amounts of data because they store the raw byte representations without the need for conversion to and from text. <br>
**Specific Use:** Often used for applications requiring precise data representation, such as executable programs, images, audio files, and scientific data.

### Precision of a Binary File
The precision of a binary file refers to how accurately the data is represented within the file. It is determined by the following factors:

Data Type and Bit Depth: The type of data and the number of bits used to represent each unit of data (e.g., 8-bit, 16-bit, 32-bit, 64-bit) significantly affect precision.

**Integer Precision:** For integers, precision depends on the bit depth. A 16-bit integer can represent 65,536 different values, while a 32-bit integer can represent over 4 billion values.
Floating-Point Precision: For floating-point numbers, precision depends on the format (e.g., single precision, double precision). Single precision (32-bit) and double precision (64-bit) formats differ in how many significant digits they can represent and their range. <br>
**File Structure:** The way data is organized in the binary file also impacts precision. For example, storing time-series data with a higher sampling rate increases temporal precision.

Encoding and Representation: The method used to encode data in the file (e.g., IEEE 754 for floating-point numbers) also affects precision.

### Practical Examples
**Electrophysiological Data:** In electrophysiological recordings, the precision of the data stored in binary files is crucial. For instance, the voltage values recorded from neurons may be stored as 16-bit or 24-bit integers, affecting how finely the voltages can be distinguished. <br>

**Image Files:** For image files, precision can refer to color depth. An 8-bit image can represent 256 different colors per channel, while a 24-bit image can represent over 16 million colors.

## Summary
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

I (SA) wrote a MATLAB script for converting .csc files to a single .dat file ( `perpl_NLX2Binary`). By default, I change the bitVolts to 0.195 because this is more commonly used in intan/openephys systems and allows for easier concatenation of files. Note that for concatenation, all files MUST have the same bitVolt. The script requires NLX Mex files.

You can download NLX to MATLAB Import/Export MEX Files from [here](https://github.com/vandermeerlab/vandermeerlab/tree/master/code-matlab/shared/io/neuralynx) <br>


### OpenEphys
New versions of OpenEphys allow for storing the data directly in [binary formats (.dat)](https://open-ephys.github.io/gui-docs/User-Manual/Recording-data/Binary-format.html). So unless you need to change the bitVolts or truncate the data, you don't have to run conversions on OpenEphys files for Kilosort spike sorting.


### View binary data
NeuroScope is an advanced viewer for neurophysiological and behavioral data: it can display local field potentials (LFPs), neuronal spikes, and behavioral events. It also features limited editing capabilities.

Download: https://neurosuite.sourceforge.net/


# Getting started with example data

### Edit the config file with desired parameters
In Kilosort, a config file refers to a configuration script or parameters file for defining the parameters and settings used during the spike sorting process. This file allows users to customize various aspects of Kilosort's operation to suit specific datasets or experimental conditions. 

[Overview of how KiloSort uses the settings](https://github.com/cortex-lab/KiloSort/wiki/Config-Variables)

Some of these parameters have not been explained on the above github page. I will try to best explain them here:


<details>

<summary>initialize</summary>

In Kilosort, the initialize parameter determins how the algorithm starts the sorting process, which can impact the efficiency and accuracy of the final spike sorting results. Here’s a closer look at the options available for the initialize parameter in Kilosort and what they signify:

'fromData': When set to 'fromData', Kilosort initializes the sorting process by using the actual recorded data to form initial clusters or templates. This involves detecting spikes in the raw data, grouping them based on their shapes and amplitudes, and forming initial templates. This method is data-driven and can adapt well to the specific characteristics of the dataset.

'no': Setting the initialize parameter to 'no' means that Kilosort will not perform any initial clustering based on the raw data. Instead, it relies on a different approach using default provided templates, to start the sorting process. This option might be used in scenarios where there is prior knowledge about the spike shapes or when re-sorting data using previously validated templates.

The choice of initialization method can depend on several factors, including the quality of the recording, the expected variability of spike shapes, and specific research needs. Proper initialization can significantly enhance the sorting quality by accurately capturing the diverse spike waveforms present in the data, which are critical for reliable neuron identification and activity analysis.

</details>



<details>

<summary>Thresholds</summary>

Kilosort 1 requires threshold values for several steps of the spike sorting which sometimes can be confusing. Here's a list:

**spkTh - Threshold for Identifying Spikes to Make Templates**
If initialize='fromData', KiloSort uses this threshold to identify a set of sample waveforms, these are then projected onto the PCs and are clustered using k-means. Each cluster is used to generate a 'template', this becomes the set of initialisation templates that KiloSort subsequently uses.

**Th - Threshold for Comparing Spike to Template**
KiloSort projects a candidate spike waveform onto each template to assess how much of the variance of that spike in the waveform can be explained by the template. This threshold allows sets how much of the variance needs to be explained to consider the waveform part of the template. In other words, the threshold is for how much variance is allowed around the template, a small value indicates a large amount of variance is allowed - allowing this template's cluster to accumulate more waveforms that vary from the template. There are 3 elements. The first 2 elements are used to create a linspace() between anneal 1 and the anneal final (nannealpasses*NBatch). e.g. 1 and 5 for 10 anneals: linspace(1,5,10). This effectively creates an increasingly harder threshold to cross for each anneal pass. The final element is used during the final template matching pass - i.e. the pass that goes through each batch sequentially and performs parallel matching.


**lam - Penalty for Amplitudes Different to the Template**
A large value of lam means that if the template needs to be scaled to match the candidate waveform, there is a large penalty associated with that. The penalty is referring to the value of similarity between the waveform and the template, hence a large penalty will cause a reduction in the similarity value. The threshold for similarity is set by Th.

</details>



<details>

<summary>Nfilt - Starting Number of Clusters</summary>

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


## Manual Curation

Manual curation in spike sorting refers to the process where a user manually reviews and adjusts the results of an automated spike sorting algorithm. During manual curation, the researcher examines the spike waveforms and their alignment to templates, checks the consistency of spike timings and shapes, and possibly reassigns or removes misclassified spikes. This process helps to correct errors that automatic algorithms might miss, especially in complex recordings with overlapping spikes or varying signal qualities. This step is essential for ensuring accuracy in the identification and classification of neural spikes. During manual curation 

In manual curation of spike sorting, the two major processes involved are splitting and merging. Typically, the decision to merge is more straightforward than splitting, so it is beneficial to set the parameters of Kilosort such that it oversplit than overmerge.

A general overview of the Phy's available tools for manual curation can be found here: https://phy.readthedocs.io/en/latest/clustering/. In the following section, I will go over more details of when to split or merge.

### Split
In the context of manual curation during spike sorting, "splitting" refers to the process of dividing a cluster of spikes that has been incorrectly grouped together into multiple, more homogeneous groups. This occurs when the automated spike sorting algorithm groups together spikes that are actually from different neurons. The curator manually examines these clusters and, using their knowledge of neuron physiology and spike shapes, reassigns spikes to new clusters that more accurately reflect the distinct neural sources. This enhances the accuracy of neuron identification and the overall reliability of the spike sorting process.

### Merge
In manual curation of spike sorting, "merging" refers to the process of combining multiple spike clusters that have been incorrectly separated into a single, more accurate cluster. This typically occurs when an automated sorting algorithm divides spikes from the same neuron into different groups due to slight variations in spike shapes or overlapping signals. During manual curation, the user examines these separate clusters and, if they determine that they likely originate from the same neuron, merges them to improve the accuracy of the neuronal identification. This helps in reducing fragmentation of spike data and ensures more reliable analysis of neural activity.

### To merge or to split? Manual Clustering Practical User's Guide

Manual curation should be considered a multiple-criteria decision process, where the reviewer inspects multiple lines of evidence to decide whether to merge, split, or keep as is. Some of the most informative Phy panels for making this decision are:


<details>

<summary>Waveform view</summary>

This view shows the waveforms of a selection of spikes, on the relevant channels (based on amplitude and proximity to the peak waveform amplitude channel).

You should consider splitting a cluster based on the waveform view in spike sorting when you observe distinct patterns or variations within the waveforms that suggest they might not all originate from the same neuron. Indicators for splitting include noticeable differences in waveform shape, amplitude, or other key features that are consistent within subsets of the cluster but different between these subsets. To make a decision to split, you can compare the average waveform of the unit with the template waveform. Sometimes, it is obvious that some of the single waveforms of the unit are different from the template. Such observations can make a case for splitting. 

You should consider merging clusters based on the waveform view in spike sorting when the waveforms in different clusters appear similar in shape, amplitude, duration, and other waveform features, suggesting they are likely from the same neuron. Merging is appropriate when there is minimal variation across these parameters, indicating a common origin, which helps in accurately capturing the activity of a single neuron. In high-density probes, the waveform of a single neuron might span multiple channels; the recorded waveform on all of these channels MUST be considered for a decision to merge. For example suppose we have two clusters with identical mean and single waveforms on channel 30, however, their waveforms on channel 29 is distinctly different. You should not merge solely based on the identical waveform on a single channel.

Due to sudden drift of the probe during the experiment or manual adjustment of the probe depth in acute setup, it is possible that the still active neurons shift their location to a new set of channels. For example, a unit with the largest amplitude previously on channel 30 might abrubtly shift to channel 29. In such cases, you need to inspect the waveform but also note other criteria (e.g. CCGs, firing patterns, FR, ...) to see if you should merge them.

More subtle drift can cause amplitude flactuations in recorded neurons (it would be like moving a microphone around when a speaker is talking so the volume of the recorded sound will vary during the session). Thus, amplitude differences alone should not be considered sufficient criteria for merging or splitting.

As disucssed before, spikes in a burst might also have different amplitudes which is noticeable on the waveform view. For these cases, it is best to check multiple examples on the trace view to make sure that the smaller amplitude spikes indeed belong to the larger amplitude unit, and merge.

</details>


<details>

<summary>Correlogram view</summary>

This view shows the autocorrelograms and cross-correlograms between all pairs of selected clusters.

Autocorrelograms and ISI distributions are crucial in spike sorting because they provide a graphical representation of the temporal correlation of a neuron's spike firing over time, showing how often a neuron fires at specific intervals. They help in identifying and confirming the physiological properties of neurons, such as refractory periods and burst patterns. Inter-spike-interval (ISI) violations are a classic measure of unit contamination. Because all neurons have a biophysical refractory period, we can assume that any spikes occurring in rapid succession (<1.5-3 ms intervals - differs based on the area of recording) come from two different neurons. In ideal cases, a clean unit must show no contamination at around 0ms.

Cross-correlograms (CCGs) are used to display the temporal correlations between spikes from two different neurons. CCGs measure the likelihood of one neuron firing in relation to the firing of another over varying time lags. This can reveal synaptic connections, such as excitatory or inhibitory influences between neurons, as well as common input from other sources. Essentially, CCGs help identify functional relationships and interactions between neurons, providing insights into the network dynamics within the recorded neural population. In spike sorting, CCGs can be used to make a decision for splitting or merging. Broadly speaking, CCGs between two neurons around 0ms latency can fall within one of 3 patters:

* Showing a peak: This can be an indication of true interaction between the two neurons (e.g. cofiring, or synaptic connectivity), or can be caused due to the artifactual double spike counting described previously. If other metrics (e.g. waveform shape across channels - should not rely too much on the amplitude though) are different between the two neurons, you may assume that the relationship is genuine. Otherwise, you may need to consider an artifactual effect. If the units are on the same channel and the peak latency is 0, check the trace view to see if the spikes are occuring mostly (doesn't have to be always) at the same time. Because it is impossible to record two different units on the same channel at the same times, you may conclude that co-occurence is artifactual.

* Showing a trough: a trough might be due to genuine inhibitory/suppression relationship between the two units (e.g. one inhibits the other) or be caused by incorrect oversplitting.

* CCG shows a uniform distribution with no peaks or troughs: This is what you should mostly expect to see during the spike sorting process which means that the sorted units do not have any relationships together.

</details>



<details>

<summary>Amplitude view</summary>

This view shows the amplitude of a selection of spikes belonging to the selected clusters, along with vertical histograms on the right. The distribution of the spike amplitudes can be used to assess the quality of the spike sorting parameters and also for split/merge decision. 

In many cases, spike amplitudes of a healthy good stable cluster must follow a Gaussian distribution with spikes durign the whole recording session. In cases, where the units have amplitude distributions with cut-offs on the smaller tail, it mgiht indicate that you have missed spikes of that unit due to a large threshold for automated spike sorting. If you have a lot of these examples, you should consider re-running the spike sorting with lower thresholds. Units with heavy-tails might indicate a bursting unit. If you have a unit with cutoffs on the larger tail, this might indicate an incorrect oversplitting. You should find the similar match clusters for merging.

Amplitude values across time can also be informative to make a decision about the stability of a unit. If the unit drifts across time, you would see amplitude fluctuations (e.g. like a wave). Sometimes due to abrupt major drifts you might lose a unit in which case the amplitude view will show spikes up to a time point. Or it might be that the units amplitude has changed and thus the cluster has been split in two. Usually, in these case, you might find another cluster that shwos spikes right after the end of the previous cluster but with shifts in amplitude.

</details>


## Decision Examples

<details>

<summary>Incorrect oversplit of a drifting unit</summary>

![UltimatePhotoEditor_2024_05_20_03_20_34](https://github.com/hoffman-lab/SpikeSortingLauncher/assets/41991280/7cd98139-0722-4b02-b4be-c4f20f84bd4b)

This is an example of a drifting unit that was split into 2 clusters during the automated spike sorting process. Note how waveforms on channel 10 and 11 have minor differences in amplitude. Also see the amplitude view for how the blue unit is drifting. The ACG of the separated units are very similar and the CCG shows a dip at 0ms latency. All of these factors indicate that we have one unit that has been mistakenly split into 2. So I'd merge these two clusters into one.

</details>



<details>

<summary>Incorrect oversplit of a drifting unit - 2</summary>

![UltimatePhotoEditor_2024_05_20_03_18_32](https://github.com/hoffman-lab/SpikeSortingLauncher/assets/41991280/8192d851-0d7b-498f-a81a-60237cd74071)

</details>


<details>

<summary>Split a contaminated cluster</summary>

![UltimatePhotoEditor_2024_05_20_03_24_09](https://github.com/hoffman-lab/SpikeSortingLauncher/assets/41991280/e29bc2db-5c03-4328-89b1-920113d88956)
![UltimatePhotoEditor_2024_05_20_03_23_28](https://github.com/hoffman-lab/SpikeSortingLauncher/assets/41991280/80b9b320-a913-4963-a79c-8177b02ba276)
![UltimatePhotoEditor_2024_05_20_03_23_48](https://github.com/hoffman-lab/SpikeSortingLauncher/assets/41991280/20fc94a9-b4ea-49fc-8149-dad0c229e4b6)

The first 2 images show the 2 clusters that were sorted by Kilosort 1. By inspecting the distribution of spikes on the Feature view, we can notice that the cluster might be contaminated and thus a case for further splitting. I used Klusta plugin on Phy to recluster these clusters. Figure 3 shows the result of this reclustering. You can see that reclustering actually brings out clusters that might be considered different.

</details>



<details>

<summary>Split a contaminated cluster 2 - Iterative process</summary>

![UltimatePhotoEditor_2024_05_20_03_33_27](https://github.com/hoffman-lab/SpikeSortingLauncher/assets/41991280/cf8ab2e0-3da8-4bfe-9c4d-d5d18b7c8699)
![UltimatePhotoEditor_2024_05_20_03_33_45](https://github.com/hoffman-lab/SpikeSortingLauncher/assets/41991280/c6e1e5bf-0b64-4635-a176-3451dd40a5d5)
![UltimatePhotoEditor_2024_05_20_03_34_07](https://github.com/hoffman-lab/SpikeSortingLauncher/assets/41991280/6743fb5f-4b20-46a5-a401-ecacce572eca)
![UltimatePhotoEditor_2024_05_20_03_34_26](https://github.com/hoffman-lab/SpikeSortingLauncher/assets/41991280/7b054747-5f50-4c9c-8bad-d55201d915fb)
![UltimatePhotoEditor_2024_05_20_03_34_57](https://github.com/hoffman-lab/SpikeSortingLauncher/assets/41991280/2f8ba5a5-4643-4a2a-87d7-2d76fb50455d)

Reclustering the above resulted in 9-10 new clusters, some of them were good and some were still bimodal. I used Kmeans clustering to clean the contaminated ones. After iterative reculustering with Klusta and Kmeans and merging, we get the result on the last figure. 

</details>




## Known issues about Kilosort 1 clustering

### Spike holes
[Spike holes: Spikes within the batching edges are not detected #594](https://github.com/MouseLand/Kilosort/issues/594)

### Double-counted spikes
[Double-counted spikes](https://github.com/MouseLand/Kilosort/issues/29)

Kilosort begins by detecting potential spikes from the raw data and forming initial templates, which are average waveforms representing common spike shapes detected across the channels. Detected spikes are assigned to the most similar template based on their shapes and amplitudes. After spikes are detected and assigned to templates, Kilosort calculates the residual signal. This residual is obtained by subtracting the contributions of the detected spikes (as represented by the templates) from the original data. Essentially, the residual signal represents what is left of the data after removing the parts that have been accounted for by the currently identified spikes and their templates. Kilosort then processes the residual signal to detect additional spikes. This step is crucial because some spikes may initially be obscured by larger, overlapping spikes. By removing the influence of the already detected spikes, the algorithm can more clearly see other spikes that were previously hidden in the noise or masked by dominant spikes. The process of assigning spikes to templates, calculating the residual, and detecting new spikes in the residual signal is repeated iteratively. With each iteration, the templates are updated to better fit the spikes assigned to them, and the residual is recalculated to reflect the most recent subtractions. By repeatedly updating the templates and recalculating the residuals, Kilosort ensures that even spikes that are temporally overlapping or of lower amplitude are detected and correctly attributed. This iterative refinement helps in minimizing the noise and improving the overall accuracy of the spike sorting process. Residual subtraction is thus a powerful technique in the Kilosort algorithm that enhances its ability to accurately sort spikes by continuously refining the signal representation. This method is particularly beneficial in dense, high-channel-count recordings where neuronal spikes frequently overlap, making traditional spike detection methods less effective.

However, this method comes with its own drawbacks. In situation where the recording contains very large spikes, a residual after template subtraction can be detected again as a separate cluster. This results in double counting the same spikes. In cases when this happens, it is easy to check for it in the crosscorrelograms (CCGs). The CCGs would show a large peak at 0 latency.

I modified a code from Adrian Bondy ('remove_ks1_duplicate_spikes') that takes the kilosort2 output rez and identifies pair of spikes that are close together in time and space.


### Over-merging
[ops.splitT and ops.mergeT and other parameters](https://github.com/cortex-lab/KiloSort/issues/68)

After initiaial clustering, Kilosort runs a posthoc merging algorithm ('merge_posthoc2') to group clusters that are similar. I wouldn't recommend the use of this algorithm. I deactivated it in my pipeline. Although, it will add more work to the manual clustering part, it worth the effort.

### Erroneous splitting due to biophysical changes in waveform

[Pyramidal cell burst spikes i.e. complex spikes show decremental amplitude](https://doi.org/10.1016/S0165-0270(99)00124-7)

Complex spikes are spontaneous bursts of about 2-10 action potentials with very short interspike intervals. The decreasing amplitude of spikes in a burst make them a difficult case for spike sorting algorithms that work solely based on waveform, especially from a single channel source. The smaller amplitude spikes occurring at the tail of a complex spike can be split as a separate, smaller, cell from the leading spikes. Such cases can be visualized as assymetric CCGs between clusters of the same channel and also viewing example spikes on the phy trace view. The rate of this error in clustering will depend on the parameters of the spike sorting especially lam and Th. It is always best to have stringent criteria and merge posthoc.

This is just one example of how subtle but systematic differences in the waveshape of a single cell can lead to sorting errors. For most of these characteristics, however, the *extracellular signal variance is highly correlated across channels* for single cells. In contrast, true multiple cells, which are necessarily separated in space, may show waveform variance in the signal that is decorrelated across channels. This is one sign of a "true" split.

see also:

[NMDAR BAPs alter waveshape](https://www.jneurosci.org/content/21/1/240)
[Electrophysiological characteristics of hippocampal complex-spike cells and theta cells](https://link.springer.com/article/10.1007/BF00238898)


### Noisy clusters
[Noisy clusters #80](https://github.com/cortex-lab/KiloSort/issues/80)

### Missing spikes #160
[Missing spikes #160](https://github.com/cortex-lab/KiloSort/issues/160)

## Further Reading
* [Spike sorting](https://www.cell.com/current-biology/pdf/S0960-9822(11)01254-1.pdf)<br>
* [Chapter 1 - Spike Sorting](https://neurophysics.ucsd.edu/publications/obd_ch3_2.pdf)<br>
* [Spike sorting: new trends and challenges of the era of high-density probes](https://iopscience.iop.org/article/10.1088/2516-1091/ac6b96/meta)<br>
* [Kilosort: realtime spike-sorting for extracellular electrophysiology with hundreds of channels](https://www.biorxiv.org/content/10.1101/061481v1.abstract)<br>
* [Solving the spike sorting problem with Kilosort](https://www.biorxiv.org/content/10.1101/2023.01.07.523036v1.abstract)<br>
* [Spike sorting with Kilosort4](https://www.nature.com/articles/s41592-024-02232-7)<br>
* [A spike sorting toolbox for up to thousands of electrodes validated with ground truth recordings in vitro and in vivo](https://elifesciences.org/articles/34518)<br>
* [How Do Spike Collisions Affect Spike Sorting Performance?](https://www.eneuro.org/content/9/5/ENEURO.0105-22.2022.abstract)<br>
* [Spike sorting: the overlapping spikes challenge](https://www.degruyter.com/document/doi/10.1515/cdbme-2015-0011/html?lang=en)<br>

history of multichannel sorting use and benefits:
* [Tetrode recording improves unit isolation and yield](https://doi.org/10.1016/0165-0270(95)00085-2)




