@ECHO OFF

REM Fetching Dust Database
CALL dust.bat

SET LIBRARY_NAME="assimp"

SET AUTO_LATEST_SRC_URL="http://sourceforge.net/projects/assimp/files/latest/download?source=files"
SET SRC_URL="http://sourceforge.net/projects/assimp/files/assimp-3.1/assimp-3.1.1_no_test_models.zip/download"
SET DOWNLOADED_FILE=assimp-3.1.1_no_test_models.zip
SET EXTRACT_COMMAND_UNCOMPRESS=%DUST_7Z% x -aoa %DOWNLOADED_FILE%
SET EXTRACT_COMMAND_ARCHIVE=
SET EXTRACTED_SRC_FOLDER=assimp-3.1.1

SET DEDICATED_PREFIX=%DUST_CURRENT_LIBRARY_DEDICATED_USR%/assimp-3.1.1

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

cmake .. %DUST_CMAKE_COMPILER_HINTS% -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="%DEDICATED_PREFIX%" -DASSIMP_ENABLE_BOOST_WORKAROUND=ON -DASSIMP_NO_EXPORT=ON -DASSIMP_BUILD_ASSIMP_TOOLS=OFF -DASSIMP_BUILD_SAMPLES=OFF -DASSIMP_BUILD_TESTS=OFF

%DUST_MAKE% -j8

%DUST_MAKE% install

CD %DUST_ROOT%



CALL dust_postinstall_lib.bat

ECHO You should be right above your newly compiled library (%LIBRARY_NAME%)

:Label_End




