#!/usr/bin/env bash

## No bash script should be considered releasable until it has this! http://j.mp/safebash ##
# Exit if any statement returns a non-true return value (non-zero).
set -o errexit
# Exit on use of an uninitialized variable
set -o nounset

changeMeta() {
    exiftool -UsePanoramaViewer=True -ProjectionType=equirectangular -artist="829 Studios" -copyright="829 Studios" -PoseHeadingDegrees=180.0 -CroppedAreaLeftPixels=0 -FullPanoWidthPixels=7500 -CroppedAreaImageHeightPixels=3750 -FullPanoHeightPixels=3750 -CroppedAreaImageWidthPixels=7500 -CroppedAreaTopPixels=0 -filename=%f_360meta.%e $1  
}

checkExif() {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  type exiftool >/dev/null 2>&1 || { return 1; }
  # return value
  return 0
}

if checkExif $1 ; then
  for file in "${@}"; do
    changeMeta $file
  done
else
  osascript -e 'tell app "System Events" to display dialog "Please Install ExifTool"' 
fi
