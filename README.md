# opto_analyser
MATLAB app to segment cell compartments and extract dynamic intensities in optogenetic experiments and then fit a system of ordinary differential equations in order to estimate rates of import and export between nuclear and cytoplasmic compartments.

## Installation
Code was written on MATLAB R2019a and remains untested on other versions. The Image Processing toolbox and Statistics and Machine Learning toolbox are required.

Operation of opto_analyser requires the app, opto_analyser.mlapp and the nonlinear model fitting script fitnlm__opto_analyser_odes.m. In addition, lsmread.m is required to read in lsm files into MATLAB arrays (https://github.com/joe-of-all-trades/lsmread).

Download all files to the same folder. Either add the folder make it the current folder. 

## Usage
Only lsm files can currently be read by the app. The lsm files must be split into a release and a recovery lsm file. Maximum number of channels is four. This must include a channel giving nuclear staining, mitochondrial staining and protein localisation. 

Type `opto_analyser_app` in the command line.

The app will load. The lefthand panel gives user input options. Select both the release and recovery lsm files. Input the desired number of window profile seedpoints in comma-separated format (e.g. '1,2,4' would generate three window profiles. The first would have a single manually input segmentation seed-point and a window-size equivalent to the movie length for percentile projections. The second would have two manually input segmentation seed-points and a moving percentile window equivalent to half the total movie length.). It is recommended to try a variety of window-profiles to compare effects of segmentation robustness (lower number of seedpoints) and ability to capture compartment motility (higher number of seedpoints). Seedpoints significntly larger than 4 will require a large degree of manual segmentation and may result in poor compartment capture.

The central panel is the location for the majority of image processing and model fitting.

Channel selection tab: Designate nuclear, mitochondrial and protein channels. Crop the image to zoom in around the cell in question. 

Compartment viewing percentiles tab: Load the next window profile and select the optimum percentile projection for each compartment for the moving window.

Cell boundary crop tab: For the next seedpoint for the current window profile, select the project that provides the clearest cell definition and then select `Rough Crop` to manually and roughly crop around the target cell.

Cell thresholding tab: Select the optimum threshold that defines the cell boundary and click `Accept Threshold`.

## Contributing

In the first instance please contact robert.jenkins@crick.ac.uk with coding errors or suggestions on making the code better or more suitable to your work.

## Author

Robert P Jenkins (robert.jenkins@crick.ac.uk)

## Licence 

Shield: [![CC BY 4.0][cc-by-shield]][cc-by]

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg
