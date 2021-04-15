@echo off
REM keep checking the Ethernet Card
REM should always be at 1Gbps
REM but sometimes seems to nego down to 100Mbps

set WinTitle=WIN%1%
echo Moving window : %WinTitle%
title %WinTitle%
:getPID
echo Trying to get PID
for /f "tokens=2 USEBACKQ" %%f IN (`tasklist /NH /FI "WINDOWTITLE eq %WinTitle%*"`) Do set myPID=%%f
if %myPID% equ No goto getPID
echo Successfully grabbed PID %myPID%
powershell -File %USERPROFILE%\source\repos\WindowsUtilities\WindowsUtilities\MoveWindow.ps1 %myPID% 3800 1900 1000 200
echo.

title Ethernet Speed
powershell -File %USERPROFILE%\source\repos\WindowsUtilities\WindowsUtilities\CheckEthernetCardSpeed.ps1 


