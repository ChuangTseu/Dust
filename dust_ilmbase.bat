@ECHO OFF

REM Fetching Dust Database
CALL dust.bat

SET LIBRARY_NAME="ilmbase"

SET AUTO_LATEST_SRC_URL="TODO"
SET SRC_URL="http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.2.0.tar.gz"
SET DOWNLOADED_FILE=ilmbase-2.2.0.tar.gz
SET EXTRACT_COMMAND_UNCOMPRESS=%DUST_7Z% x -aoa ilmbase-2.2.0.tar.gz
SET EXTRACT_COMMAND_ARCHIVE=%DUST_7Z% x -aoa ilmbase-2.2.0.tar
SET EXTRACTED_SRC_FOLDER=ilmbase-2.2.0

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

cmake .. -G"MinGW Makefiles" %DUST_CMAKE_COMPILER_HINT% -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="%DUST_ROOT%\%EXTRACTED_SRC_FOLDER%" -DNAMESPACE_VERSIONING=OFF

make -j8

make install

CD %DUST_ROOT%

ECHO You should be right above your newly compiled library (%LIBRARY_NAME%)

:Label_End



