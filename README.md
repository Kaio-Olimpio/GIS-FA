# GIS-FA

This repository contains a detailed tutorial on how to perform the GIS-FA analyses, described in the paper "GIS-FA: An approach to integrating thematic maps, factor-analytic, and envirotyping for cultivar targeting" (*the link will be available soon*). 

**ATTENTION: The `shapefile` folder referred to in the pipeline is quite large, and could not be loaded into GitHub. Thus, before reproducing the analysis, you may want to download the shapefiles from this [link](https://drive.google.com/drive/u/1/folders/1dshP1ZI1pWBNJMa4foX_nGwb-nQub__d)**

## Overview

GIS-FA is a method that integrates Factor Analytic (FA) linear mixed models, geographic information systems (GIS), partial least-squares (PLS) regression and enviromics to predict phenotypic performance in untested environments. In a nutshell, GIS-FA:

1. Fits a FA linear mixed model using data from observed environments
2. Downloads environmental features of the whole target population of environments
3. Performs an environmental characterization, comparing the environmental conditions of observed and unobserved environments
4. Uses the loadings of the observed environments, obtained from the FA model, to train a PLS model fed with environmental features. The goal is to predict the unobserved environments' loadings.
5. Returns to the FA: the predicted loadings are used in factorial regressions to predict the empirical BLUPs of the selection candidates in unobserved environments.
6. Wraps-up the outcomes to build sophisticated thematic maps (genotype adaptation map, pairwise comparison maps, which-won-where maps...)

![unnamed-chunk-76-1-1](https://github.com/Kaio-Olimpio/GIS-FA/assets/101746579/6bc2ecbe-163c-4728-ab49-0150338d47ab)

## Content

Here, you will find: 

- `data`: In this folder is the `data_soy.csv` file, which you can use to reproduce the analysis. It is one of the datasets used in the paper.
- `misc`: Some miscellaneous to correctly render the `Pipeline.pdf` file from `Pipeline.rmd`. 
- `saves`: The pipeline is quite large, and some procedures take considerable time. In this folder, there are `.RDA`, `.RData` and `.rds` files you can use to load into `R`. These files contain the outcomes of these procedures, so you can skip some steps and expedite the analysis.
- `FA_spatmod_soybean.R`: In the paper, we promised that we would show the FA-spatial model used in the soybean dataset. Well, here it is.
- `Pipeline.rmd` and `Pipeline.pdf`: This is the main document of this repo. These files contain the tutorial you can use as a guide to reproduce the analysis. Both files have the same content, but the `.rmd` file contains the crude code used to build the `.pdf` file. 

Please, feel free to contact me or any contributor of this repo for any enquiries, suggestions or issues. 


