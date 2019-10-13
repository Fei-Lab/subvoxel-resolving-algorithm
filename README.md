# subvoxel-resolving-algorithm

> Executable program and example data for Subvoxel-resolving algorithm.

## Requirements:

* Windows 7 or later
* NVIDIA CUDA Toolkit 7.5 and 8.0

## Install 

Download and unpack the repository.

## Usage

1. Unpack the example data /subvoxel-resolving-algorithm/test data/raw.zip in place.

2. Open profile.ini, set “INPUT0” to the example data path.Note: 

   * The images should be sequential tif images with the same prefix pattern.

   * The width and height of each image should be the same and integer multiples of 128 px.
	
3. Edit and save commom.ini. The options are as follow:

   * Output_dir : directory to save the results.
 
   * PSFfile: your PSF file path.
 
   * X_src, Y_src, Z_src : Width, height and sequence length of the input (in pixels).
 
   * XZ_angle, YZ_angle: the off-axial angle (degree).
 
   * Z_step : light-sheet scanning step size (in um).
 
   * X_res, Y_res : lateral voxel size of the input (in um, determined by the magnification and the camera sensor patch size).
 
   * Z_res : axial voxel size of the input (in um, usually is half of the light-sheet thickness).
 
   * X_factor, Y_factor, Z_factor : resolution enhancement factors.
 
   * PSF_X, PSF_Y : size of the PSF (in pixels).
	 
4. Double click run.bat. The "Deconvxx.tif" under the output diretory is the final result.
