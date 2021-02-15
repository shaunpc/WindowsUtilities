@echo off

set WinTitle=WIN%1%
echo Moving window : %WinTitle%
title %WinTitle%
:getPID
echo Trying to get PID
for /f "tokens=2 USEBACKQ" %%f IN (`tasklist /NH /FI "WINDOWTITLE eq %WinTitle%*"`) Do set myPID=%%f
if %myPID% equ No goto getPID
echo Successfully grabbed PID %myPID%
powershell -File D:\DevStuff\Powershell\MoveWindow.ps1 %myPID% 4000 140 800 1500
echo.

REM start cmd /k ping www.google.com -t
color 0E
title pingTrend Constant
ping -t -4 www.google.com|cmd /q /v /c "(pause&pause)>nul & for /l %%a in () do (set /p "data=" && echo(IP4 !time! !data!)&ping -n 2 -4 www.google.com>nul"
