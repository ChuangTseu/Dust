@ECHO OFF
SETLOCAL EnableDelayedExpansion

SET LastFunctionReturn=0

SET HAS_LIBSTDCPP=0
SET HAS_LIBWINPTHREAD=0
SET HAS_LIBGCC=0

REM Fetching Dust Database
CALL dust.bat

if "%1" == "" GOTO Label_Fuck

if "%2" == "" (
	SET LEVEL=0
	SET PRINT_OFFSET=
)

if "%2" == "1" (
	SET LEVEL=1
	SET PRINT_OFFSET=     
)

if "%2" == "2" (
	SET LEVEL=2
	SET PRINT_OFFSET=          
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

if NOT ERRORLEVEL 1 GOTO Label_End

REM objdump.exe -p %OBJ_NAME% | grep "DLL Name"

REM GOTO Label_End

GOTO Label_Process
 
 
:Label_Process

objdump.exe -p %OBJ_NAME% | grep "DLL Name" > ldd_output_%LEVEL%.txt
	
(for /F "tokens=1,2 delims=^:" %%a in (ldd_output_%LEVEL%.txt) do (		
	CALL:IsWin32Dll %%b	
			
	IF !IsWin32Dll_RETURN! == 0 (
		echo %LEVEL%%PRINT_OFFSET%%%b
		
		set /a NEXT_LEVEL=!LEVEL!+1
		
		CALL dust_ldd %%b !NEXT_LEVEL!
		
		REM CALL:IsMingwDll %%b
		REM IF !IsMingwDll_RETURN! == 0 (
		REM )			
	)	
))
	
GOTO Label_End

:Label_Fuck

ECHO Go FUCK Yourself :p

GOTO Label_End


:Label_End

REM if !LEVEL! == 0 (
	REM echo.endlevel0
	REM ECHO HAS_LIBSTDCPP !HAS_LIBSTDCPP!
	REM ECHO HAS_LIBWINPTHREAD !HAS_LIBWINPTHREAD!
	REM ECHO HAS_LIBGCC !HAS_LIBGCC!
REM )

if exist ldd_output_%LEVEL%.txt rm ldd_output_%LEVEL%.txt

GOTO:EOF



REM Utilities

:IsWin32Dll

SET IsWin32Dll_RETURN=0

set IsWin32Dll_OBJ_NAME=


for /f "delims=" %%i in ('which %~1 2^>NUL') do set IsWin32Dll_OBJ_NAME=%%i

if not exist "%IsWin32Dll_OBJ_NAME%" GOTO End_IsWin32Dll

echo %IsWin32Dll_OBJ_NAME% | grep Windows\\system32 > NUL
IF NOT ERRORLEVEL 1 SET IsWin32Dll_RETURN=1

:End_IsWin32Dll

SET LastFunctionReturn=%IsWin32Dll_RETURN%
REM ECHO Should be %LastFunctionReturn%

GOTO:EOF


:IsMingwDll

SET IsMingwDll_RETURN=0

set IsMingwDll_OBJ_NAME=%~1

echo %IsMingwDll_OBJ_NAME% | grep libstdc++ > NUL
IF NOT ERRORLEVEL 1 (
	SET IsMingwDll_RETURN=1
	SET HAS_LIBSTDCPP=1
	GOTO End_IsMingwDll
)
echo %IsMingwDll_OBJ_NAME% | grep libwinpthread > NUL
IF NOT ERRORLEVEL 1 (
	ECHO YEAH
	SET IsMingwDll_RETURN=1
	SET HAS_LIBWINPTHREAD=1
	GOTO End_IsMingwDll
)

echo %IsMingwDll_OBJ_NAME% | grep libgcc > NUL
IF NOT ERRORLEVEL 1 (
	SET IsMingwDll_RETURN=1
	SET HAS_LIBGCC=1
	GOTO End_IsMingwDll
)

:End_IsMingwDll

SET LastFunctionReturn=%IsMingwDll_RETURN%
REM ECHO Should be %LastFunctionReturn%

GOTO:EOF




