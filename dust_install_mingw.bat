@ECHO OFF

REM Fetching Dust Database
CALL dust.bat

SET DUST_MINGW_W64=%DUST_MINGW_ROOT%/mingw-w64

echo %DUST_MINGW_W64%

CD %DUST_MINGW_ROOT%

wget "http://sourceforge.net/projects/mingw-w64/files/Toolchains targetting Win32/Personal Builds/mingw-builds/installer/repository.txt/download"

cat repository.txt | grep posix | grep dwarf > correct_repo.txt
cat repository.txt | grep posix | grep seh >> correct_repo.txt

GOTO Label_i686

ECHO i686 (32bit) or x86_64 (64bit) ?
SET /P answer="Type (32, 64, i686 or x86_64) ? %=%"

IF "%answer%"=="32" GOTO Label_i686
IF "%answer%"=="i686" GOTO Label_i686
IF "%answer%"=="64" GOTO Label_x86_64
IF "%answer%"=="x86_64" GOTO Label_x86_64

GOTO Label_Fuck

:Label_i686

set arch=i686

ECHO Installing i686
cat correct_repo.txt | grep i686 > arch_repo.txt
GOTO Label_Choice

:Label_x86_64

set arch=x86_64

ECHO Installing x86_64
cat correct_repo.txt | grep x86_64 > arch_repo.txt
GOTO Label_Choice

:Label_Choice

ECHO Choose you distro among:

REM Delim , won't be find in the file -> we've got our new line delimiter...
(for /F "tokens=1,2 delims= " %%a in (arch_repo.txt) do (
   echo %%a %%b
))

ECHO Which one ?
SET /P version="Type 'version number'(ex: 4.9.2) ? %=%"

cat arch_repo.txt | grep %version% > version_repo.txt
IF ERRORLEVEL 1 GOTO Label_Fuck

ECHO Choose revision:

(for /F "tokens=1,2 delims= " %%a in (version_repo.txt) do (
   echo %%b
))

ECHO Which one ?
SET /P revision="Type 'revn'(ex: rev0) ? %=%"

echo %revision% | grep rev > NUL
IF ERRORLEVEL 1 GOTO Label_Fuck

cat version_repo.txt | grep %revision% > ultimate_choise_repo.txt

for /f "delims=" %%i in ('cat ultimate_choise_repo.txt ^| wc -l') do set return=%%i
IF not "%return%"=="1" GOTO Label_Fuck

:Label_Test

for /f "tokens=1 delims=," %%i in ('cat ultimate_choise_repo.txt') do set str=%%i

set x="%str%"

for /f "delims=" %%i in ('echo %x% ^| grep -o http.*$') do set download_url=%%i

set download_url=%download_url:"=%
set download_url="%download_url%"

echo %download_url%

set x=%x%
set x=%x:|= %
set x=%x:/= %
set x=%x:"=%

REM for /f "delims=" %%i in ('echo %x% ^| grep -o %arch%-.*$') do set downloaded_file=%%i

for /f "tokens=1 delims=," %%i in ('echo %x% ^| awk -F" "  "{print $(NF)}"') do set downloaded_file=%%i
ECHO %downloaded_file%	

for /f "tokens=1 delims=," %%i in ('echo %downloaded_file% ^| awk -F".7z" "{print $(1)}"') do set final_directory=%%i
ECHO %final_directory%

if not exist mingw-w64 mkdir mingw-w64

if not exist %DUST_MINGW_W64%/%final_directory% GOTO Label_Install

	ECHO %final_directory% seems already installed. Reinstalling will crush ancient installation (custom files remaining).
	
	SET /P answer="Reinstall (y/n) ? %=%"

	IF "%answer%"=="y" GOTO Label_Install
	IF "%answer%"=="yes" GOTO Label_Install
	IF "%answer%"=="n" GOTO Label_NoReinstall
	IF "%answer%"=="no" GOTO Label_NoReinstall

	GOTO Label_Fuck
	
	GOTO Label_AlreadyDownloaded


:Label_Install

if not exist %downloaded_file% GOTO Label_Downloaded
	
ECHO %downloaded_file% already downloaded
GOTO Label_AlreadyDownloaded


:Label_Downloaded

wget %download_url%

:Label_AlreadyDownloaded

ECHO Installing. This might take a while. Even on SSD.

REM CD %DUST_MINGW_W64%

%DUST_7Z% x -aoa %downloaded_file% -o%DUST_MINGW_W64%/%final_directory%

:Label_NoReinstall

ECHO Nothing to do. Leaving.

GOTO Label_End

REM echo %x% | grep -o [^^,][^^,]*$
REM echo %x% | rev | cut -d, -f1 | rev

GOTO Label_Fuck

:Label_Fuck

ECHO Go FUCK Yourself :p

GOTO Label_End


:Label_End

REM CLEANUP

rm ultimate_choise_repo.txt
rm version_repo.txt
rm correct_repo.txt
rm arch_repo.txt



