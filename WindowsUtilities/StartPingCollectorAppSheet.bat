@echo off

set WinTitle=WIN%1%
echo Moving window : %WinTitle%
title %WinTitle%
:getPID
echo Trying to get PID
for /f "tokens=2 USEBACKQ" %%f IN (`tasklist /NH /FI "WINDOWTITLE eq %WinTitle%*"`) Do set myPID=%%f
if %myPID% equ No goto getPID
echo Successfully grabbed PID %myPID%
powershell -File D:\DevStuff\Powershell\MoveWindow.ps1 %myPID% 3100 1000 900 700
echo.

cd C:\Users\shaun\PycharmProjects\pingTrend
color 0A 
title pingTrend Google Sheets Collector
start /b python collect-sheets.py