# FFMpeg includes/shared libs for vgmstream

Special build that only enables some audio formats used by vgmstream.
Can be used to compile and run vgmstream with FFMPEG enabled.

You can also use other full/prebuilt packages, like those at https://ffmpeg.zeranoe.com/ (32bit shared and dev).


# Compiling

Launch ffmpeg-build.sh.

In Windows you'll need to have in PATH:
- Standalone (non MSYS2) GCC like mingw-w64 (https://sourceforge.net/projects/mingw-w64/). On install, if you are unsure you can choose i686 (32 bit) and Win32 threads.
- yasm (http://yasm.tortall.net/)

It may be possible to build FFMpeg with MSVC following the official docs (see https://www.ffmpeg.org/)


In Windows you could use:
```
set PATH=C:\Program Files (x86)\Git\bin;%PATH%
set PATH=C:\Program Files (x86)\mingw-w64\i686-5.4.0-win32-sjlj-rt_v5-rev0\mingw32\bin;%PATH%
set PATH=C:\projects\yasm;%PATH%
set PATH=C:\projects\gnuwin32\bin;%PATH%

cd vgmstream-ffmpeg
sh ffmpeg-build.sh 
```
