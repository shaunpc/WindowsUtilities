@echo off

if "%~1"=="" goto justRUN

set WinTitle=WIN%1%
echo Moving window : %WinTitle%
title %WinTitle%
:getPID
echo Trying to get PID
for /f "tokens=2 USEBACKQ" %%f IN (`tasklist /NH /FI "WINDOWTITLE eq %WinTitle%*"`) Do set myPID=%%f
if %myPID% equ No goto getPID
echo Successfully grabbed PID %myPID%
powershell -File %USERPROFILE%\source\repos\WindowsUtilities\WindowsUtilities\MoveWindow.ps1 %myPID% 4000 140 800 1500
echo.

REM start cmd /k ping www.google.com -t
title pingTrend Constant
color 0E
:justRUN
ping -t www.google.com|cmd /q /v /c "(pause&pause)>nul & for /l %%a in () do (set /p "data=" && echo(IP4 !time! !data!)&ping -n 2 www.google.com>nul"

REM
REM    (pause&pause) ignores the first two lines of the input
REM			cmd /Q = quiet - turn echo off
REM				/V delayed variable expansion , V:ON enables !var! to be expanded to use var at execution time
REM				/C carries out command in string, then terminates

