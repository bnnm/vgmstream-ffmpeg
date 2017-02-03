#!/bin/sh

# FFMpeg source (relative to the sh)
FFMPEG_SRC="../FFMpeg"


# move to FFMpeg
cd $FFMPEG_SRC

# create FFMpeg based on config
make || exit 1 

# copy results to FFMPEG_OUT
make install || exit 1 
