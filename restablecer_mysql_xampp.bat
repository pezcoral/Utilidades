rem 2:42:10 p. m.  [mysql] 	Attempting to start MySQL app...
rem 2:42:10 p. m.  [mysql] 	Status change detected: running
rem 2:42:12 p. m.  [mysql] 	Status change detected: stopped
rem 2:42:12 p. m.  [mysql] 	Error: MySQL shutdown unexpectedly.
rem 2:42:12 p. m.  [mysql] 	This may be due to a blocked port, missing dependencies, 
rem 2:42:12 p. m.  [mysql] 	improper privileges, a crash, or a shutdown by another method.
rem 2:42:12 p. m.  [mysql] 	Press the Logs button to view error logs and check
rem 2:42:12 p. m.  [mysql] 	the Windows Event Viewer for more clues
rem 2:42:12 p. m.  [mysql] 	If you need more help, copy and post this
rem 2:42:12 p. m.  [mysql] 	entire log window on the forums

@echo off
echo Hola, vas a arreglar el problema de XAMPP. Pulsa Enter para continuar.
pause

set "dataPath=E:\xampp\mysql\data"
set "backupPath=E:\xampp\mysql\backup"
set "oldDataPath=E:\xampp\mysql\data_old"

rem Renombrar la carpeta data a data_old
ren "%dataPath%" "data_old"
echo Renombrada carpeta actual a data_old.
rem Duplicar la carpeta backup con el nuevo nombre data
xcopy /E /I "%backupPath%" "%dataPath%"
echo Restableciendo la carpeta data desde la copia de seguridad.
rem Copiar el archivo ibdata1 de data_old a data
copy "%oldDataPath%\ibdata1" "%dataPath%"
echo Restableciendo la estructura de las bases de datos.
rem Copiar las carpetas que no se llamen ni "mysql", ni "performance_schema", ni "phpmyadmin", ni "test"
for /D %%G in ("%oldDataPath%\*") do (
    if not "%%~nxG"=="mysql" if not "%%~nxG"=="performance_schema" if not "%%~nxG"=="phpmyadmin" if not "%%~nxG"=="test" (
        xcopy /E /I "%%G" "%dataPath%\%%~nxG"
        echo Restableciendo la base de datos: %%~nxG 
    )
)
echo Restablecimiento completado. Pulsa Enter para salir.
