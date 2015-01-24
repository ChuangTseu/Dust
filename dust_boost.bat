@ECHO OFF

REM Fetching Dust Database
CALL dust.bat

SET LIBRARY_NAME="boost"

SET AUTO_LATEST_SRC_URL="TODO"
SET SRC_URL="http://switch.dl.sourceforge.net/project/boost/boost/1.57.0/boost_1_57_0.7z"
SET DOWNLOADED_FILE=boost_1_57_0.7z
SET EXTRACT_COMMAND_UNCOMPRESS=%DUST_7Z% x -aoa boost_1_57_0.7z
SET EXTRACT_COMMAND_ARCHIVE=
SET EXTRACTED_SRC_FOLDER=boost_1_57_0

SET DEDICATED_PREFIX=%DUST_CURRENT_LIBRARY_DEDICATED_USR%/boost_1_57_0

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


REM TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! 

set DUST_BOOST_COMPIL_ROOT=%DUST_ROOT%/Compils/%EXTRACTED_SRC_FOLDER%

REM cd tools/build

REM DONTFORGET! 

REM CALL bootstrap.bat mingw

REM b2 install --prefix=%DUST_BOOST_COMPIL_ROOT%/build/tools toolset=gcc

REM ENSURE ML IS IN YOUR PATH
REM SET PATH=C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin\amd64_x86;%PATH%

b2 toolset=gcc link=shared 

REM --prefix=C:\Users\Robin\TestBed\BOOST\

REM b2 install toolset=gcc REM --prefix=C:\Users\Robin\TestBed\BOOST\ 

REM IF "%DUST_BOOST_PATH_ALREADY_SET%" == "TRUE" GOTO Label_PathAlreadySet

REM echo SETTING BOOST SPECIFIC PATH
REM set PATH=%DUST_BOOST_COMPIL_ROOT%/build/tools;%PATH%
REM set DUST_BOOST_PATH_ALREADY_SET=TRUE

:Label_PathAlreadySet
REM --build-dir=%DUST_BOOST_COMPIL_ROOT%/build stage

REM b2 --build-dir=. toolset=gcc variant=release link=shared threading=single address-model=32 --show-libraries

REM b2 toolset=gcc complete stage

:CurrentStep


REM TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! TEMPORARY ! 

GOTO Label_End

cmake .. %DUST_CMAKE_COMPILER_HINTS% -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="%DEDICATED_PREFIX%"


:Label_PathAlreadySet

%DUST_MAKE% -j8

%DUST_MAKE% install

CD %DUST_ROOT%



CALL dust_postinstall_lib.bat

ECHO You should be right above your newly compiled library (%LIBRARY_NAME%)



:Label_End


