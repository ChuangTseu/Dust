@ECHO OFF

REM Fetching Dust Database
CALL dust.bat

SET LIBRARY_NAME="openal"

SET AUTO_LATEST_SRC_URL="TODO"
SET SRC_URL="http://kcat.strangesoft.net/openal-releases/openal-soft-1.16.0.tar.bz2"
SET DOWNLOADED_FILE=openal-soft-1.16.0.tar.bz2
SET EXTRACT_COMMAND_UNCOMPRESS=%DUST_7Z% x -aoa openal-soft-1.16.0.tar.bz2
SET EXTRACT_COMMAND_ARCHIVE=%DUST_7Z% x -aoa openal-soft-1.16.0.tar
SET EXTRACTED_SRC_FOLDER=openal-soft-1.16.0

SET DEDICATED_PREFIX=%DUST_CURRENT_LIBRARY_DEDICATED_USR%/openal-soft-1.16.0

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

if not exist build MKDIR build

CD build

cmake .. -G"MinGW Makefiles" %DUST_CMAKE_COMPILER_HINT% -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="%DEDICATED_PREFIX%"

%DUST_MAKE% -j8

%DUST_MAKE% install

CD %DUST_ROOT%



CALL dust_postinstall_lib.bat

ECHO You should be right above your newly compiled library (%LIBRARY_NAME%)

:Label_End




