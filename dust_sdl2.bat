@ECHO OFF

REM SDK VERSION ! SDK VERSION ! SDK VERSION ! SDK VERSION ! SDK VERSION ! SDK VERSION ! SDK VERSION ! SDK VERSION !
REM Why fight hard when there's an easy solution ?

REM Fetching Dust Database
CALL dust.bat

SET LIBRARY_NAME="sdl2"

SET AUTO_LATEST_SRC_URL="TODO"
SET SDK_URL="https://www.libsdl.org/release/SDL2-devel-2.0.3-mingw.tar.gz"
SET DOWNLOADED_FILE=SDL2-devel-2.0.3-mingw.tar.gz
SET EXTRACT_COMMAND_UNCOMPRESS=%DUST_7Z% x -aoa SDL2-devel-2.0.3-mingw.tar.gz
SET EXTRACT_COMMAND_ARCHIVE=%DUST_7Z% x -aoa SDL2-devel-2.0.3-mingw.tar
SET EXTRACTED_SDK_FOLDER=SDL2-2.0.3

SET SDL2_INSTALL_PREFIX="%DUST_ROOT%/SDL2-2.0.3"

CD %DUST_ROOT%

if not exist Compils MKDIR Compils

CD Compils

if exist %DOWNLOADED_FILE% GOTO Label_AlreadyDownloaded

ECHO DOWNLOADING MOFO
wget --no-check-certificate %SDK_URL%

:Label_AlreadyDownloaded

if exist %EXTRACTED_SDK_FOLDER% GOTO Label_AlreadyExtracted

ECHO EXTRACTING MOFO
%EXTRACT_COMMAND_UNCOMPRESS%
%EXTRACT_COMMAND_ARCHIVE%

:Label_AlreadyExtracted

REM CD %EXTRACTED_SDK_FOLDER%

:Label_Install
REM GLEW CUSTOM INSTALL

if not exist %SDL2_INSTALL_PREFIX% MKDIR %SDL2_INSTALL_PREFIX%

cp -r %EXTRACTED_SDK_FOLDER%/i686-w64-mingw32/* %SDL2_INSTALL_PREFIX%

CD %DUST_ROOT%

ECHO You should be right above your newly compiled library (%LIBRARY_NAME%)

:Label_End



