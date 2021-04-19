# opto_analyser
MATLAB app to segment cell compartments and extract dynamic intensities in optogenetic experiments and then fit a system of ordinary differential equations in order to estimate rates of import and export between nuclear and cytoplasmic compartments.

## Installation

To run the app from MATLAB:

Code was written on MATLAB R2019a and remains untested on other versions. The Image Processing toolbox and Statistics and Machine Learning toolbox are required.

Operation of opto_analyser requires the app, opto_analyser.mlapp and the nonlinear model fitting script fitnlm__opto_analyser_odes.m. In addition, lsmread.m is required to read in lsm files into MATLAB arrays (https://github.com/joe-of-all-trades/lsmread).

Download all files to the same folder. Either add the folder make it the current folder. 

## Usage
Only lsm files can currently be read by the app. The lsm files must be split into a release and a recovery lsm file. Maximum number of channels is four. This must include a channel giving nuclear staining, mitochondrial staining and protein localisation. 

To run the app from MATLAB type `opto_analyser_app` in the command line to load the app.

The lefthand panel gives user input options. Select both the release and recovery lsm files (`Load Release Data` and `Load Recovery Data`). Input the desired number of window profile seedpoints in comma-separated format (e.g. '1,2,4' would generate three window profiles. The first would have a single manually input segmentation seed-point and a window-size equivalent to the movie length for percentile projections. The second would have two manually input segmentation seed-points and a moving percentile window equivalent to half the total movie length.). It is recommended to try a variety of window-profiles to compare effects of segmentation robustness (lower number of seedpoints) and ability to capture compartment motility (higher number of seedpoints). Seedpoints significntly larger than 4 will require a large degree of manual segmentation and may result in poor compartment capture. Al processing and analysis can be rest at any point by clicking on `RESET`.

The central panel is the location for the majority of image processing and model fitting.

`Channel selection` tab: Designate nuclear, mitochondrial and protein channels. Crop the image to zoom in around the cell in question. 

`Compartment viewing percentiles` tab: Load the next window profile and select the optimum percentile projection for each compartment for the moving window.

`Cell boundary crop` tab: For the next seedpoint for the current window profile, select the project that provides the clearest cell definition and then select `Rough Crop` to manually and roughly crop around the target cell.

`Cell thresholding` tab: Move sliders to select the optimum threshold that defines the cell boundary. Cell boundary overlay updates in real time in the central panel. Click `Accept Threshold`.

`Compartment thresholding` tab: Move the sliders to select the optimum threshold that defines the nuclear and mitochndrial boundaries. Compartment overlay boundaries update in real time in the central panel. Extracted intensity profiles update in real time on the righthand panel. These profiles are pre-interpolation. All previously analysed window profiles and seedpoints for the current window profile are shown to aid comparison between differing window-profiles and to observe dynamic changes as intensity profiles develop as more seedpoints are added. Click `Accept thresholds`.

`Interpolation` tab: Interpolation of compartment thresholds and crop boundaries is carried out and then segmentation is carried out on the moving percentile projections of each compartment for each window-profile. This extracts all raw compartment intensity profiles. The user can then `save data and quit` or `proceed to normalisation` (and model fitting).

`Background subtraction` tab: The user can define a ROI of background to carry out background subtraction. A `Include background subtraction` tickbox exists to indicate whether the user wants to include background subtraction. Then click `Accept Background Region`.

`Normalisation regions` tab: Use the sliders to select the normalisation regions. It is recommended (using the output images and sliders) to select regions far from initial release and recovery to avoid noise from these events from affecting the normalisation). The single linear normalisation assume the same rate of passive bleaching in release and recovery phases and fits a single fit to the combined data from both the release and recovery regions. The bilinear fit assumes different rates of passive bleaching in the release and recovery phases and fits a linear fit to data in the release and data in the recovery separately. Select `Accept Normalisation Regions`.

`Time and SS Input` tab: Manually record the final frame where the system is in steady-state prior to release. Select time units as `Use frames as time` or `Load time data` and select `Confirm`. If `Load time data` has been selected then select the relevant time data file with the corresponding time information. In a future release this will be extracted directly from the metadata.

`Normalisation plotting` tab: Allows visualisation of linear fits used to normalise data to passive bleaching (`Pre-normalisation`) and the resulting normalised intensity profiles (`Post-normalisation`) for all window-profiles (`Number of windows`) and `Normalisation` method. Select `Proceed to model fit` if you wish to fit the system of ODEs to the data and `Save and quit` if not.

`Model fitting` tab: Fits the system of ODEs with initial parameter guesses given as editable numeric boxes. To keep the guesses as they appear in *** and based on FRAP experiments then use default values. Select `Fit model` to fit the system of ODEs to each of the window-profiles subject to both linear and bilinear normalisation. Following fitting, badly fitted intensity profiles can be refit individually by ticking `Re-fit`. Parameter guesses can be edited and models re-fit. Only intensity profiles with a tick will be re-fit. `Reset Guesses` resets parameter values to those in xxx. Clicking `Save and Quit` will allow you to save both all out =put as a .mat datafile and parameter values and output features as a csv file. The app then resets to allow another processing of a new cell.

`Model fitting output`tab: Presents all model fits to intensity profiles for all window-profiles and normalisation methods to give a visual indication of quality of fits. 

## Example Data

To illustrate the functionality of the app, an example experiment is provided in example_cell. Download this data to see how opto_analyser works.

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
