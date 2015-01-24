@ECHO OFF

REM Fetching Dust Database
CALL dust.bat

SET LIBRARY_NAME="openexr"

SET AUTO_LATEST_SRC_URL="TODO"
SET SRC_URL="http://download.savannah.nongnu.org/releases/openexr/openexr-2.2.0.tar.gz"
SET DOWNLOADED_FILE=openexr-2.2.0.tar.gz
SET EXTRACT_COMMAND_UNCOMPRESS=%DUST_7Z% x -aoa openexr-2.2.0.tar.gz
SET EXTRACT_COMMAND_ARCHIVE=%DUST_7Z% x -aoa openexr-2.2.0.tar
SET EXTRACTED_SRC_FOLDER=openexr-2.2.0

SET DEDICATED_PREFIX=%DUST_CURRENT_LIBRARY_DEDICATED_USR%/openexr-2.2.0

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

cmake .. %DUST_CMAKE_COMPILER_HINTS% -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="%DEDICATED_PREFIX%" -DNAMESPACE_VERSIONING=OFF -DILMBASE_PACKAGE_PREFIX="%DUST_CURRENT_LIBRARY_DEDICATED_USR%/ilmbase-2.2.0" -DZLIB_ROOT="%DUST_CURRENT_LIBRARY_DEDICATED_USR%/zlib-1.2.8"

SET var=%PATH%
SET searchVal=ilmbase-2.2.0
ECHO %PATH%|FINDSTR /i %searchVal% >nul
IF ERRORLEVEL 1 (
	echo ilmbase-2.2.0 not yet in PATH. Addind it
) ELSE (
	echo ilmbase-2.2.0 already in base. Nothing to do.
	GOTO Label_PathAlreadySet
)

set PATH=%DUST_CURRENT_LIBRARY_DEDICATED_USR%/ilmbase-2.2.0/bin;%PATH%

:Label_PathAlreadySet

%DUST_MAKE% -j8

%DUST_MAKE% install

CD %DUST_ROOT%



CALL dust_postinstall_lib.bat

ECHO You should be right above your newly compiled library (%LIBRARY_NAME%)



:Label_End



