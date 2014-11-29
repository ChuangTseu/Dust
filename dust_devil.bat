@ECHO OFF

REM SDK VERSION ! SDK VERSION ! SDK VERSION ! SDK VERSION ! SDK VERSION ! SDK VERSION ! SDK VERSION ! SDK VERSION !
REM Seems too hard to compile for windows mingw. MSVC .libs do the job just right. 

REM Fetching Dust Database
CALL dust.bat

SET LIBRARY_NAME="devil"

SET AUTO_LATEST_SRC_URL="TODO"
SET SDK_URL="http://sourceforge.net/projects/openil/files/DevIL Windows SDK/1.7.8/DevIL-SDK-x86-1.7.8.zip/download?use_mirror=switch"
SET DOWNLOADED_FILE=DevIL-SDK-x86-1.7.8.zip
SET EXTRACT_COMMAND_UNCOMPRESS=%DUST_7Z% x -aoa DevIL-SDK-x86-1.7.8.zip -oDevIL-SDK-x86-1.7.8
SET EXTRACT_COMMAND_ARCHIVE=
SET EXTRACTED_SDK_FOLDER=DevIL-SDK-x86-1.7.8

SET DEVIL_INSTALL_PREFIX="%DUST_ROOT%/DevIL-1.7.8"

CD %DUST_ROOT%

if not exist Compils MKDIR Compils

CD Compils

if exist %DOWNLOADED_FILE% GOTO Label_AlreadyDownloaded

ECHO DOWNLOADING MOFO
wget %SDK_URL%

:Label_AlreadyDownloaded

if exist %EXTRACTED_SDK_FOLDER% GOTO Label_AlreadyExtracted

ECHO EXTRACTING MOFO
%EXTRACT_COMMAND_UNCOMPRESS%
%EXTRACT_COMMAND_ARCHIVE%

:Label_AlreadyExtracted

REM CD %EXTRACTED_SDK_FOLDER%

:Label_Install
REM GLEW CUSTOM INSTALL

if not exist %DEVIL_INSTALL_PREFIX% MKDIR %DEVIL_INSTALL_PREFIX%

cp -r %EXTRACTED_SDK_FOLDER%/* %DEVIL_INSTALL_PREFIX%

CD %DUST_ROOT%

ECHO You should be right above your newly compiled library (%LIBRARY_NAME%)

:Label_End



