# Spike Sorting with Kilosort
Spike Sorting launcher: setup, tutorial, examples, best practice for Hoffman Lab data
	
------------------------------------------------------------------------
This repository will help you get started spike sorting for high resoluton probes like DBC's Deep array probes 64, 128 ch (or Neuropixels probes). 

The software you need and example data are either linked to or reside on the lab's file server https://129.59.231.19:5001  ('/datahome_2/AnalysisTools/SpikeSorting/ `).

------------------------------------------------------------------------

## General Principles you need to know before you start
## Physiology of signal and sorting algorithm limitations

## Articles
[How Do Spike Collisions Affect Spike Sorting Performance?](https://www.eneuro.org/content/9/5/ENEURO.0105-22.2022.abstract)


## Tutorials

Spike sorting with Kilosort - Marius Pachitariu (HHMI): https://www.youtube.com/watch?v=cmrAhhquC9E&t=2s <br>
Using Phy to curate spike sorting - Nick Steinmetz (UW): https://www.youtube.com/watch?v=N7AsWVk5JVk&t=1783s <br>
Important spike sorting info: https://edmerix.github.io/SpikeSorting/

## Resources
Spike sorting benchmark: https://spikeforest.flatironinstitute.org/ <br>
Unit Quality Metrics: https://allensdk.readthedocs.io/en/latest/_static/examples/nb/ecephys_quality_metrics.html <br>

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

### Other packages for quality control, and extracting basic physiological features

CellExplorer: https://cellexplorer.org/ <br>
Bombcell: https://github.com/Julie-Fabre/bombcell <br>

## Preprocessing data for Spike Sorting

Preprocessing comprises formatting data into Kilosort compatible format (binary files) and cleaning the data (e.g. removing common noise across channels).

### Formatting data
Kilosort can read a single binary file (e.g. .dat with specific precisions e.g. 16bit) which contains all channels and data points in [channel by timepoint] structure. We use Neurolynx for our wireless recordings in the lab which means that we need to convert our data from Neuralynx .ncs files to .dat file. I wrote a script that performs the data conversion `perpl_NLX2Binary`.


### 
Common Average Referencing: https://github.com/cortex-lab/spikes/blob/master/preprocessing/applyCARtoDat.m



## Getting started with example data
