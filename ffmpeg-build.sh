#!/bin/sh

# builds FFmpeg DLLs

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
CONFIG+=" --enable-decoder=aac,ac3,adpcm_adx,adpcm_psx,adpcm_xa,atrac3,atrac3p,bink,binkaudio_dct,binkaudio_rdft,flac,mp3float,pcm_s16be,pcm_s16be_planar,pcm_s16le,pcm_s16le_planar,vorbis,wmalossless,wmapro,wmav1,wmav2,wmavoice,xma1,xma2"
#CONFIG+=",dca,dsd_lsbf,dsd_lsbf_planar,dsd_msbf,dsd_msbf_planar,tak"
CONFIG+=" --enable-demuxer=aac,ac3,adx,asf,bink,flac,mov,mp3,msf,ogg,oma,wav,xmv,xwma"
#CONFIG+=",dsf,dts,dtshd,tak"
CONFIG+=" --enable-parser=ac3,mpegaudio,vorbis,xma"
#CONFIG+=" --enable-encoder=pcm_s16be,pcm_s16be_planar,pcm_s16le,pcm_s16le_planar"
#CONFIG+=" --enable-muxer=wav"
#CONFIG+=" --enable-protocol=data,file,subfile"
#CONFIG+=" --enable-filter=aformat,ainterleave,aresample"
# GCC options (PIC shouldn't be needed on Windows)
#CONFIG+=" --enable-pic"
#CONFIG+=" --extra-cflags=-fPIC"
#CONFIG+=" --extra-cflags=-m32"
CONFIG+=" --extra-ldflags=-static-libgcc"
CONFIG+=" --build-suffix=-vgmstream"


# move to FFMpeg
cd $FFMPEG_SRC

# configure FFMpeg
sh configure $CONFIG || exit 1 

# create FFMpeg based on config
make || exit 1 

# copy results to FFMPEG_OUT
make install || exit 1 


# info
CC_VERSION=$(gcc --version | head -n 1)
FFMPEG_VERSION=$(git describe --always --tag)
INFOTXT="vgmstream-ffmpeg

Compiler: $CC_VERSION
FFMpeg version: $FFMPEG_VERSION

Config:
 $CONFIG
"
echo "$INFOTXT" > $FFMPEG_OUT/ffmpeg-build.txt
