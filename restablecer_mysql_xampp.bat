
rem ****************************************************
rem ****************************************************
rem Attempting to start MySQL app...
rem Status change detected: running
rem Status change detected: stopped
rem Error: MySQL shutdown unexpectedly.
rem This may be due to a blocked port, missing dependencies, 
rem improper privileges, a crash, or a shutdown by another method.
rem Press the Logs button to view error logs and check
rem the Windows Event Viewer for more clues
rem If you need more help, copy and post this
rem entire log window on the forums
rem ****************************************************
rem ****************************************************

@echo off
echo Hola, vas a arreglar el problema de XAMPP. Pulsa Enter para continuar.
pause

set "dataPath=E:\xampp\mysql\data"
set "backupPath=E:\xampp\mysql\backup"

rem Obtener la fecha y hora actual y formatearla para usarla en el nombre de la carpeta
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "datetime=%%a"
set "datetime=%datetime:~0,8%_%datetime:~8,6%"

set "oldDataPath=E:\xampp\mysql\data_old_%datetime%"

rem Renombrar la carpeta data a data_old con la marca de tiempo
ren "%dataPath%" "data_old_%datetime%"
echo Renombrada carpeta actual a data_old_%datetime%.

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
pause
