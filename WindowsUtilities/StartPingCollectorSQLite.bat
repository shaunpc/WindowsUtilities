@echo off

for /f %%a in ('wmic path win32_localtime get dayofweek /format:list ^| findstr "="') do set %%a
echo Day of week is %DayOfWeek%
if %DayOfWeek% gtr 0 if %DayOfWeek% lss 6 goto ok
choice /C YN /T 10 /D N /M "It's the Weekend, do you want this to run"
if %ERRORLEVEL% EQU 1 goto ok
exit
:ok

set WinTitle=WIN%random%%random%
echo Moving window : %WinTitle%
title %WinTitle%
:getPID
echo Trying to get PID
for /f "tokens=2 USEBACKQ" %%f IN (`tasklist /NH /FI "WINDOWTITLE eq %WinTitle%*"`) Do set myPID=%%f
if %myPID% equ No goto getPID
echo Successfully grabbed PID %myPID%
powershell -File D:\DevStuff\Powershell\MoveWindow.ps1 %myPID% 3100 140 800 500
echo.

cd C:\Users\shaun\PycharmProjects\pingTrend
color 0B
title pingTrend Local SQLite Collector
start /b python collect-sqlite.py

