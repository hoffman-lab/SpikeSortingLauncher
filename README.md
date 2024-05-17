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
CortexLab: https://github.com/cortex-lab <br>
Spike sorting benchmark: https://spikeforest.flatironinstitute.org/ <br>
Unit Quality Metrics: https://allensdk.readthedocs.io/en/latest/_static/examples/nb/ecephys_quality_metrics.html <br>
Buzcode: https://github.com/buzsakilab/buzcode <br>
Cell Explorer (Framework for analyzing single cells): https://cellexplorer.org/ <br>
Bombcell (Curation of electrophysiology spike sorted units): https://github.com/Julie-Fabre/bombcell <br>
Kilosort instructions on how to manually curate electrophysiological data using Kilosort: https://github.com/singerlabgt/kilosort2-pipeline/blob/master/tutorial/instructions.md <br>
Special Cases and Questions for Kilosort Decisions: https://github.com/singerlabgt/kilosort2-pipeline/blob/master/tutorial/special-cases.md <br>
Spikeanalysis (Python): https://github.com/zm711/spikeanalysis <br>
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

Preprocessing comprises formatting data into Kilosort compatible format (binary files) and cleaning the data (e.g. removing common noise across channels).

### Formatting data
Kilosort can read a single binary file (e.g. .dat with specific precisions e.g. 16bit) which contains all channels and data points in [channel by timepoint] structure. We use Neurolynx for our wireless recordings in the lab which means that we need to convert our data from Neuralynx .ncs files to .dat file. I wrote a script that performs the data conversion `perpl_NLX2Binary`.


### 
Common Average Referencing: https://github.com/cortex-lab/spikes/blob/master/preprocessing/applyCARtoDat.m



## Getting started with example data
