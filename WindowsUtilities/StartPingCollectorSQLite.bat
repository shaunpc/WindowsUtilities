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
powershell -File %USERPROFILE%\source\repos\WindowsUtilities\WindowsUtilities\MoveWindow.ps1 %myPID% 3100 140 800 500
echo.

title pingTrend Local SQLite Collector
:justRUN
cd %USERPROFILE%\PycharmProjects\pingTrend
color 0B
# start /b python collect-sqlite.py
start python collect-sqlite.py
EXIT 0