@ECHO OFF

REM Fetching Dust Database
CALL dust.bat

SET LIBRARY_NAME="fftw3"

SET AUTO_LATEST_SRC_URL="TODO"
SET SRC_URL="http://sourceforge.net/projects/glew/files/glew/1.11.0/glew-1.11.0.zip/download"
SET DOWNLOADED_FILE=glew-1.11.0.zip
SET EXTRACT_COMMAND_UNCOMPRESS=%DUST_7Z% x -aoa glew-1.11.0.zip
SET EXTRACT_COMMAND_ARCHIVE=
SET EXTRACTED_SRC_FOLDER=glew-1.11.0

SET GLEW_INSTALL_PREFIX="%DUST_ROOT%\%EXTRACTED_SRC_FOLDER%"

CD %DUST_ROOT%

if not exist Compils MKDIR Compils

CD Compils

if exist %DOWNLOADED_FILE% GOTO Label_AlreadyDownloaded

ECHO DOWNLOADING MOFO
wget %SRC_URL%

:Label_AlreadyDownloaded

if exist %EXTRACTED_SRC_FOLDER% GOTO Label_AlreadyExtracted

ECHO EXTRACTING MOFO
%EXTRACT_COMMAND_UNCOMPRESS%
%EXTRACT_COMMAND_ARCHIVE%

:Label_AlreadyExtracted

CD %EXTRACTED_SRC_FOLDER%

REM if not exist build MKDIR build

REM CD build

REM GLEW CUSTOM BUILD

if not exist lib MKDIR lib
if not exist bin MKDIR bin

REM WIP: CODE TO RUN INTO MSYS FOR BUILDING FFTW3 WITH FLOAT (TODO: ADD DOUBLE)
REM WIP: CODE TO RUN INTO MSYS FOR BUILDING FFTW3 WITH FLOAT (TODO: ADD DOUBLE)
REM WIP: CODE TO RUN INTO MSYS FOR BUILDING FFTW3 WITH FLOAT (TODO: ADD DOUBLE)
REM WIP: CODE TO RUN INTO MSYS FOR BUILDING FFTW3 WITH FLOAT (TODO: ADD DOUBLE)

PATH=$PATH:/c/mingw-w64/i686-4.9.2-posix-dwarf-rt_v3-rev0/mingw32/bin

./configure --host=i686-w64-mingw32 --build=i686-w64-mingw32 --with-our-malloc16 --with-windows-f77-mangling --enable-shared --disable-static --enable-threads --with-combined-threads --enable-portable-binary --enable-sse2 --with-incoming-stack-boundary=2 --enable-float  CC=C:/mingw-w64/i686-4.9.2-posix-dwarf-rt_v3-rev0/mingw32/bin/gcc

REM WIP: CODE TO RUN INTO MSYS FOR BUILDING FFTW3 WITH FLOAT (TODO: ADD DOUBLE)
REM WIP: CODE TO RUN INTO MSYS FOR BUILDING FFTW3 WITH FLOAT (TODO: ADD DOUBLE)
REM WIP: CODE TO RUN INTO MSYS FOR BUILDING FFTW3 WITH FLOAT (TODO: ADD DOUBLE)
REM WIP: CODE TO RUN INTO MSYS FOR BUILDING FFTW3 WITH FLOAT (TODO: ADD DOUBLE)


:Label_Install
REM GLEW CUSTOM INSTALL

if not exist %GLEW_INSTALL_PREFIX% MKDIR %GLEW_INSTALL_PREFIX%

cp -r bin %GLEW_INSTALL_PREFIX%\
cp -r lib %GLEW_INSTALL_PREFIX%\
cp -r include %GLEW_INSTALL_PREFIX%\

REM make install

CD %DUST_ROOT%

ECHO You should be right above your newly compiled library (%LIBRARY_NAME%)

:Label_End



