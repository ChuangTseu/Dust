@ECHO OFF

REM SDK VERSION ! SDK VERSION ! SDK VERSION ! SDK VERSION ! SDK VERSION ! SDK VERSION ! SDK VERSION ! SDK VERSION !
REM Why fight hard when there's an easy solution ?

REM Fetching Dust Database
CALL dust.bat

SET LIBRARY_NAME="sfml"

SET AUTO_LATEST_SRC_URL="TODO"
SET SDK_URL="http://mirror3.sfml-dev.org/files/SFML-2.2-windows-gcc-4.9.2-mingw-32-bit.zip"
SET DOWNLOADED_FILE=SFML-2.2-windows-gcc-4.9.2-mingw-32-bit.zip
SET EXTRACT_COMMAND_UNCOMPRESS=%DUST_7Z% x -aoa SFML-2.2-windows-gcc-4.9.2-mingw-32-bit.zip
SET EXTRACT_COMMAND_ARCHIVE=
SET EXTRACTED_SDK_FOLDER=SFML-2.2

SET DEDICATED_PREFIX=%DUST_CURRENT_LIBRARY_DEDICATED_USR%/SFML-2.2

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

if not exist %DEDICATED_PREFIX% MKDIR "%DEDICATED_PREFIX%"

cp -r %EXTRACTED_SDK_FOLDER%/* %DEDICATED_PREFIX%

CD %DUST_ROOT%



CALL dust_postinstall_lib.bat

ECHO You should be right above your newly compiled library (%LIBRARY_NAME%)

:Label_End



