@ECHO OFF

IF "%MINGW_DISTRIBUTION_SET%"=="TRUE" echo MINGW DISTRO ALREADY SET

REM Temporary. Will provide full self-contained distribution later
IF NOT "%MINGW_DISTRIBUTION_SET%"=="TRUE" CALL mingw.bat

SET DUST_ROOT=C:\Users\Robin\Desktop\PROJET\Utilities\updateRessourcesScript\Dust

SET DUST_TOOLS_PATH=%DUST_ROOT%

SET DUST_COMPILER_ROOT=C:\mingw-w64\i686-4.9.2-posix-dwarf-rt_v3-rev0\mingw32

SET DUST_COMPILER_BINDIR=%DUST_COMPILER_ROOT%\bin

SET DUST_C_EXE=gcc
SET DUST_CXX_EXE=g++
SET DUST_MAKE_EXE=mingw32-make.exe
SET DUST_AR_EXE=ar.exe

SET DUST_GCC=%DUST_COMPILER_BINDIR%\%DUST_C_EXE%
SET DUST_GXX=%DUST_COMPILER_BINDIR%\%DUST_CXX_EXE%
SET DUST_MAKE=%DUST_COMPILER_BINDIR%\%DUST_MAKE_EXE%
SET DUST_AR=%DUST_COMPILER_BINDIR%\%DUST_AR_EXE%

SET DUST_CMAKE_COMPILER_HINT=-DCMAKE_MAKE_PROGRAM="%DUST_MAKE%"



REM External Tools

SET DUST_7Z=%DUST_TOOLS_PATH%\7z


REM TODO Box2D OpenAL fftw

