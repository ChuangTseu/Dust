@ECHO OFF
SETLOCAL EnableDelayedExpansion

SET LastFunctionReturn=0

REM Fetching Dust Database
CALL dust.bat

if "%1" == "" GOTO Label_Fuck

if "%2" == "" (
	SET LEVEL=0
	SET PRINT_OFFSET=
)

if "%2" == "1" (
	SET LEVEL=1
	SET PRINT_OFFSET=........
)

if exist %1 ( 
	SET OBJ_NAME=%1	
	GOTO Label_Process
)

which %1 2>NUL > NUL
if ERRORLEVEL 1 GOTO Label_End

for /f "delims=" %%i in ('which %1') do set OBJ_NAME=%%i

if not exist "%OBJ_NAME%" GOTO Label_Fuck

echo %OBJ_NAME% | grep Windows\\system32 > NUL

if ERRORLEVEL 0 GOTO Label_End

REM objdump.exe -p %OBJ_NAME% | grep "DLL Name"

REM GOTO Label_End

GOTO Label_Process
 
 
:Label_Process

objdump.exe -p %OBJ_NAME% | grep "DLL Name" > ldd_output_%LEVEL%.txt
	
(for /F "tokens=1,2 delims=^:" %%a in (ldd_output_%LEVEL%.txt) do (		
	CALL:IsWin32Dll %%b
	REM echo %%b !LastFunctionReturn!
	
	REM echo ........................... %%b
		
	IF !LastFunctionReturn! == 0 (
		if %LEVEL% == 0 echo %%b
		if %LEVEL% == 1 echo      %%b
	
		if %LEVEL% == 0 CALL dust_ldd %%b 1
	)	
))
	
GOTO Label_End

:Label_Fuck

ECHO Go FUCK Yourself :p

GOTO Label_End


:Label_End

if exist ldd_output_%LEVEL%.txt rm ldd_output_%LEVEL%.txt

GOTO:EOF



REM Utilities

:IsWin32Dll

SET LastFunctionReturn=0

set IsWin32Dll_OBJ_NAME=


for /f "delims=" %%i in ('which %~1 2^>NUL') do set IsWin32Dll_OBJ_NAME=%%i

if not exist "%IsWin32Dll_OBJ_NAME%" GOTO End_IsWin32Dll

echo %IsWin32Dll_OBJ_NAME% | grep Windows\\system32 > NUL
IF NOT ERRORLEVEL 1 SET LastFunctionReturn=1

:End_IsWin32Dll

REM ECHO Should be %LastFunctionReturn%

GOTO:EOF


