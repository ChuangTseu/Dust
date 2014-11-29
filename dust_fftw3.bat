@ECHO OFF

REM Fetching Dust Database
CALL dust.bat

SET LIBRARY_NAME="fftw3"

SET AUTO_LATEST_SRC_URL="TODO"
SET SRC_URL="http://www.fftw.org/fftw-3.3.4.tar.gz"
SET DOWNLOADED_FILE=fftw-3.3.4.tar.gz
SET EXTRACT_COMMAND_UNCOMPRESS=%DUST_7Z% x -aoa fftw-3.3.4.tar.gz
SET EXTRACT_COMMAND_ARCHIVE=%DUST_7Z% x -aoa fftw-3.3.4.tar
SET EXTRACTED_SRC_FOLDER=fftw-3.3.4

SET DEDICATED_PREFIX=%DUST_CURRENT_LIBRARY_DEDICATED_USR%/fftw-3.3.4

CD %DUST_ROOT%

if not exist Compils MKDIR Compils

CD Compils

if exist %DOWNLOADED_FILE% GOTO Label_AlreadyDownloaded

ECHO DOWNLOADING MOFO
wget %SRC_URL%

:Label_AlreadyDownloaded

SET OPTIONAL_PREFIX=_double
if "%1" == "float" SET OPTIONAL_PREFIX=_float

ECHO %OPTIONAL_PREFIX%

REM TEMP "hack", in case we need float or double
if exist %EXTRACTED_SRC_FOLDER%%OPTIONAL_PREFIX% GOTO Label_AlreadyExtracted

ECHO EXTRACTING MOFO
%EXTRACT_COMMAND_UNCOMPRESS%
%EXTRACT_COMMAND_ARCHIVE%

mv %EXTRACTED_SRC_FOLDER% %EXTRACTED_SRC_FOLDER%%OPTIONAL_PREFIX%

:Label_AlreadyExtracted

CD %EXTRACTED_SRC_FOLDER%%OPTIONAL_PREFIX%

REM if not exist build MKDIR build

REM CD build

REM WIP: CODE TO RUN INTO MSYS FOR BUILDING FFTW3 WITH FLOAT (TODO: ADD DOUBLE)
REM WIP: CODE TO RUN INTO MSYS FOR BUILDING FFTW3 WITH FLOAT (TODO: ADD DOUBLE)
REM WIP: CODE TO RUN INTO MSYS FOR BUILDING FFTW3 WITH FLOAT (TODO: ADD DOUBLE)
REM WIP: CODE TO RUN INTO MSYS FOR BUILDING FFTW3 WITH FLOAT (TODO: ADD DOUBLE)

REM IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! IN A SH FILE ! 

%DUST_MSYS_BIN%/sh customFftwConfigureAndBuild.sh %1

REM WIP: CODE TO RUN INTO MSYS FOR BUILDING FFTW3 WITH FLOAT (TODO: ADD DOUBLE)
REM WIP: CODE TO RUN INTO MSYS FOR BUILDING FFTW3 WITH FLOAT (TODO: ADD DOUBLE)
REM WIP: CODE TO RUN INTO MSYS FOR BUILDING FFTW3 WITH FLOAT (TODO: ADD DOUBLE)
REM WIP: CODE TO RUN INTO MSYS FOR BUILDING FFTW3 WITH FLOAT (TODO: ADD DOUBLE)

:Label_Install

CD %DUST_ROOT%



CALL dust_postinstall_lib.bat

ECHO You should be right above your newly compiled library (%LIBRARY_NAME%)

:Label_End



