@ECHO OFF

REM Fetching Dust Database
CALL dust.bat

SET LIBRARY_NAME="openal"

SET AUTO_LATEST_SRC_URL="TODO"
SET SRC_URL="https://box2d.googlecode.com/files/Box2D_v2.3.0.7z"
SET DOWNLOADED_FILE=Box2D_v2.3.0.7z
SET EXTRACT_COMMAND_UNCOMPRESS=%DUST_7Z% x -aoa Box2D_v2.3.0.7z
SET EXTRACT_COMMAND_ARCHIVE=
SET EXTRACTED_SRC_FOLDER=Box2D_v2.3.0

SET DEDICATED_PREFIX=%DUST_CURRENT_LIBRARY_DEDICATED_USR%/Box2D_v2.3.0

CD %DUST_ROOT%

if not exist Compils MKDIR Compils

CD Compils

if exist %DOWNLOADED_FILE% GOTO Label_AlreadyDownloaded

ECHO DOWNLOADING MOFO
wget --no-check-certificate %SRC_URL%

:Label_AlreadyDownloaded

if exist %EXTRACTED_SRC_FOLDER% GOTO Label_AlreadyExtracted

ECHO EXTRACTING MOFO
%EXTRACT_COMMAND_UNCOMPRESS%
%EXTRACT_COMMAND_ARCHIVE%

:Label_AlreadyExtracted

CD %EXTRACTED_SRC_FOLDER%

REM BOX2D ADDITIONAL STEP
CD Box2D

if not exist build MKDIR build

CD build

cmake .. %DUST_CMAKE_COMPILER_HINTS% -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="%DEDICATED_PREFIX%" -DBOX2D_INSTALL=ON -DBOX2D_BUILD_EXAMPLES=OFF -DBOX2D_BUILD_SHARED=ON -DBOX2D_INSTALL_DOC=OFF

%DUST_MAKE% -j8

%DUST_MAKE% install

CD %DUST_ROOT%



CALL dust_postinstall_lib.bat

ECHO You should be right above your newly compiled library (%LIBRARY_NAME%)

:Label_End




