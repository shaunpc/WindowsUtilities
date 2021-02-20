@echo off

set WinTitle=WIN%1%
echo Moving window : %WinTitle%
title %WinTitle%
:getPID
echo Trying to get PID
for /f "tokens=2 USEBACKQ" %%f IN (`tasklist /NH /FI "WINDOWTITLE eq %WinTitle%*"`) Do set myPID=%%f
if %myPID% equ No goto getPID
echo Successfully grabbed PID %myPID%
powershell -File %USERPROFILE%\source\repos\WindowsUtilities\WindowsUtilities\MoveWindow.ps1 %myPID% 4000 2000 800 400
echo.

cd C:\Users\shaun\PycharmProjects\pingTrend
color 0D
title PingTrend Matplotlib Visualiser
start /b "PingTrend Matplotlib Visualiser" python graph.py

REM    now we have to wait a while until the matplotlib WINDOW TITLE stablises
:waitPID
echo Waiting for MatPlotLib Window to complete load
timeout 5 > nul
for /f "tokens=2 USEBACKQ" %%f IN (`tasklist /NH /FI "IMAGENAME eq python.exe" /FI "WINDOWTITLE eq Ping Trend*"`) Do set myPID=%%f
if %myPID% equ No goto waitPID
echo Found window Process ID : %myPID%
powershell -File %USERPROFILE%\source\repos\WindowsUtilities\WindowsUtilities\MoveWindow.ps1 %myPID% 3075 2000 1700 700
exit