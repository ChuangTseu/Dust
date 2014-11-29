@ECHO OFF

REM Fetching Dust Database
CALL dust.bat

SET LIBRARY_NAME="freeglut"

SET AUTO_LATEST_SRC_URL="TODO"
SET SRC_URL="http://sourceforge.net/projects/freeglut/files/freeglut/3.0.0 Release Candidate 1/freeglut-3.0.0-rc1.tar.gz/download?use_mirror=heanet&download="
SET DOWNLOADED_FILE=freeglut-3.0.0-rc1.tar.gz
SET EXTRACT_COMMAND_UNCOMPRESS=%DUST_7Z% x -aoa freeglut-3.0.0-rc1.tar.gz
SET EXTRACT_COMMAND_ARCHIVE=%DUST_7Z% x -aoa freeglut-3.0.0-rc1.tar
SET EXTRACTED_SRC_FOLDER=freeglut-3.0.0-rc1

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

GOTO Label_End

cmake .. -G"MinGW Makefiles" %DUST_CMAKE_COMPILER_HINT% -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="%DUST_ROOT%/%EXTRACTED_SRC_FOLDER%" -DFREEGLUT_BUILD_DEMOS=OFF

%DUST_MAKE% -j8

%DUST_MAKE% install

CD %DUST_ROOT%

ECHO You should be right above your newly compiled library (%LIBRARY_NAME%)

:Label_End




