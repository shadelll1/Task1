@echo off
rem ===========================================================================
rem  build test-data processor and open it in 1C:Enterprise
rem  Settings (base path, extension name, platform): .1c-devbase.ps1
rem  Close Konfigurator and 1C:Enterprise first - training version = one session.
rem ===========================================================================
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0tools\testdata.ps1" %*
set "RC=%ERRORLEVEL%"
pause
exit /b %RC%
