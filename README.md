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
[How Do Spike Collisions Affect Spike Sorting Performance?](https://www.eneuro.org/content/9/5/ENEURO.0105-22.2022.abstract)


## Tutorials

Spike sorting with Kilosort - Marius Pachitariu (HHMI): https://www.youtube.com/watch?v=cmrAhhquC9E&t=2s <br>
Using Phy to curate spike sorting - Nick Steinmetz (UW): https://www.youtube.com/watch?v=N7AsWVk5JVk&t=1783s <br>
Important spike sorting info: https://edmerix.github.io/SpikeSorting/

## External Resources
* CortexLab: https://github.com/cortex-lab <br>
* Spike sorting benchmark: https://spikeforest.flatironinstitute.org/ <br>
* Unit Quality Metrics: https://allensdk.readthedocs.io/en/latest/_static/examples/nb/ecephys_quality_metrics.html <br>
* Buzcode: https://github.com/buzsakilab/buzcode <br>
* Cell Explorer (Framework for analyzing single cells): https://cellexplorer.org/ <br>
* Bombcell (Curation of electrophysiology spike sorted units): https://github.com/Julie-Fabre/bombcell <br>
* Kilosort instructions on how to manually curate electrophysiological data using Kilosort: https://github.com/singerlabgt/kilosort2-pipeline/blob/master/tutorial/instructions.md <br>
* Special Cases and Questions for Kilosort Decisions: https://github.com/singerlabgt/kilosort2-pipeline/blob/master/tutorial/special-cases.md <br>
* Spikeanalysis (Python): https://github.com/zm711/spikeanalysis <br>
Pynapple (PYthon Neural Analysis Package): https://github.com/pynapple-org/pynapple <br>



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
