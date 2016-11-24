#!/bin/sh

# FFMpeg source (relative to the sh)
FFMPEG_SRC="../FFMpeg"
# FFmpeg output folder (relative to FFMPEG_SRC, not the sh)
FFMPEG_OUT="../vgmstream-ffmpeg"


# configure options
CONFIG+=" --enable-gpl"
#CONFIG+=" --enable-version3"
#CONFIG+=" --disable-logging"
CONFIG+=" --prefix=$FFMPEG_OUT"
CONFIG+=" --disable-static"
CONFIG+=" --enable-shared"
# disable all but audio
CONFIG+=" --disable-doc"
CONFIG+=" --disable-programs"
CONFIG+=" --disable-avdevice"
CONFIG+=" --disable-swresample"
CONFIG+=" --disable-swscale"
CONFIG+=" --disable-postproc"
CONFIG+=" --disable-avfilter"
CONFIG+=" --disable-network"
CONFIG+=" --disable-devices"
CONFIG+=" --disable-iconv"
CONFIG+=" --disable-schannel"
CONFIG+=" --disable-dxva2"
CONFIG+=" --disable-nvenc"
CONFIG+=" --disable-debug"
# formats
CONFIG+=" --disable-everything"
CONFIG+=" --enable-decoder=aac,ac3,atrac3,atrac3p,mp3float,xma1,xma2"
CONFIG+=" --enable-demuxer=aac,ac3,mp3,msf,ogg,oma,wav"
CONFIG+=" --enable-parser=ac3"
# GCC options (PIC shouldn't be needed on Windows)
#CONFIG+=" --enable-pic"
#CONFIG+=" --extra-cflags=-fPIC"
#CONFIG+=" --extra-cflags=-m32"
CONFIG+=" --extra-ldflags=-static-libgcc"


# move to FFMpeg
cd $FFMPEG_SRC

# configure FFMpeg
sh configure $CONFIG || exit 1 

# create FFMpeg based on config
make || exit 1 

# copy results to FFMPEG_OUT
make install || exit 1 


# info
FFMPEG_VERSION=$(git describe --always --tag)
INFOTXT="vgmstream-ffmpeg

FFMpeg version: $FFMPEG_VERSION

Config:
 $CONFIG
"
echo "$INFOTXT" > $FFMPEG_OUT/ffmpeg-build.txt