@ECHO OFF

if not exist %DEDICATED_PREFIX% (
	ECHO Lib folder %DEDICATED_PREFIX% doesn't exist. Abort.
	
	GOTO:EOF
)

cd %DEDICATED_PREFIX%

if not exist lib (
	ECHO Lib folder %DEDICATED_PREFIX% does not have any ./lib subfolder. Abort.
	
	GOTO:EOF
)

if not exist bin mkdir bin

for /f %%i in ('ls lib/*.dll') do (
	echo %%i
	
	mv %%i bin/
)

cp -r * %DUST_CURRENT_USR%

