@ECHO OFF

REM Fetching Dust Database
CALL dust.bat

SET LIBRARY_NAME="glew"

SET AUTO_LATEST_SRC_URL="TODO"
SET SRC_URL="http://sourceforge.net/projects/glew/files/glew/1.11.0/glew-1.11.0.zip/download"
SET DOWNLOADED_FILE=glew-1.11.0.zip
SET EXTRACT_COMMAND_UNCOMPRESS=%DUST_7Z% x -aoa glew-1.11.0.zip
SET EXTRACT_COMMAND_ARCHIVE=
SET EXTRACTED_SRC_FOLDER=glew-1.11.0

SET GLEW_INSTALL_PREFIX="%DUST_ROOT%\%EXTRACTED_SRC_FOLDER%"

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

REM GLEW CUSTOM BUILD

if not exist lib MKDIR lib
if not exist bin MKDIR bin

%DUST_GCC% -DGLEW_NO_GLU -O2 -Wall -W -Iinclude  -DGLEW_BUILD -o src/glew.o -c src/glew.c
%DUST_GCC% -shared -Wl,-soname,libglew32.dll -Wl,--out-implib,lib/libglew32.dll.a    -o lib/glew32.dll src/glew.o -lglu32 -lopengl32 -lgdi32 -luser32 -lkernel32

REM Create library file: lib/libglew32.dll.a
%DUST_AR% cr lib/libglew32.a src/glew.o

%DUST_GCC% -DGLEW_NO_GLU -DGLEW_MX -O2 -Wall -W -Iinclude  -DGLEW_BUILD -o src/glew.mx.o -c src/glew.c
%DUST_GCC% -shared -Wl,-soname,libglew32mx.dll -Wl,--out-implib,lib/libglew32mx.dll.a -o lib/glew32mx.dll src/glew.mx.o -L/mingw/lib -lglu32 -lopengl32 -lgdi32 -luser32 -lkernel32

REM Create library file: lib/libglew32mx.dll.a
%DUST_AR% cr lib/libglew32mx.a src/glew.mx.o

REM Make the glew visualinfo program. Skip this if you want just the lib
%DUST_GCC% -c -O2 -Wall -W -Iinclude  -o src/glewinfo.o src/glewinfo.c
%DUST_GCC% -O2 -Wall -W -Iinclude  -o bin/glewinfo.exe src/glewinfo.o -Llib  -lglew32 -lglu32 -lopengl32 -lgdi32 -luser32 -lkernel32
%DUST_GCC% -c -O2 -Wall -W -Iinclude  -o src/visualinfo.o src/visualinfo.c
%DUST_GCC% -O2 -Wall -W -Iinclude  -o bin/visualinfo.exe src/visualinfo.o -Llib  -lglew32 -lglu32 -lopengl32 -lgdi32 -luser32 -lkernel32


:Label_Install
REM GLEW CUSTOM INSTALL

if not exist %GLEW_INSTALL_PREFIX% MKDIR %GLEW_INSTALL_PREFIX%

cp -r bin %GLEW_INSTALL_PREFIX%\
cp -r lib %GLEW_INSTALL_PREFIX%\
cp -r include %GLEW_INSTALL_PREFIX%\

REM make install

CD %DUST_ROOT%

ECHO You should be right above your newly compiled library (%LIBRARY_NAME%)

:Label_End



