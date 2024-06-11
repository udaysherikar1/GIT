@echo OFF

set ALTAIR_HOME_DIR=C:\Program Files\Altair\2021.1

set CUR_DIR=%~dp0
echo %CUR_DIR%
set TCL_VERSION=tcl8.5.9
set OSBIT=WIN64
set WISH_EXEC=wish85.exe

call "%ALTAIR_HOME_DIR%/hwdesktop/hw/tcl/%TCL_VERSION%/%OSBIT%/bin/%WISH_EXEC%" "%CUR_DIR%/convertH3D.tcl"
REM start /B /MIN "%ALTAIR_HOME_DIR%/hwdesktop/hw/tcl/%TCL_VERSION%/%OSBIT%/bin/%WISH_EXEC%" "%CUR_DIR%/convertH3D.tcl"



