# MRIpostproc

Cognitive and Brain Health Laboratory 2026-19-5

### Installation

```         
install.packages("pak") 
pak::pak("CogBrainHealthLab/FCtools")
```

### Overview

This package contains tools:

- To post-process, export fMRI, ASL data into analyzable formats

  - `CIFTItoFC` : Generate FC matrices from XCP-D processed dtseries

  - `CIFTItoFC_concat_ses` : Generate FC matrices from XCP-D processed dtseries while concatenating multiple runs within each session

  - `CIFTI_subj_avg` : Compute the average FSLRv data across multiple runs for each subject

  - `extractFS.ROI` : Extract Destrieux atlas and ASEG ROIs from FreeSurfer's `LHDestrieux.table`, `LHDestrieux.table` and `aseg.vol.table` files

- To prepare data for preprocessing

  - `modifyJSON` : Edit .JSON files

  - `editJSON_IntendedFor` : Edit fmap's JSON files

- To assist downloading of HCP data from NIMH data archive

  - `extract_links` : Extract links from data manifests

  - `extract_linksXCP` : Extract links of XCP-d minimal inputs and FreeSurfer surface data from data manifests

- Quality control for preprocessed data

  - `headmotion.fmriprep` : Collate motion parameters from fMRIprep and generating bash script to delete fMRI volumes with excessive headmotion

  - `headmotion.XCP` : Collate motion parameters from XCP-D and generating bash script to delete fMRI volumes with excessive headmotion

  - `asl.QC` : Collate QC parameters from ASLprep
