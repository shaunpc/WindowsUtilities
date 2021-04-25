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
powershell -File %USERPROFILE%\source\repos\WindowsUtilities\WindowsUtilities\MoveWindow.ps1 %myPID% 3600 1850 1200 150
echo.

title Ethernet Speed
start powershell -File %USERPROFILE%\source\repos\WindowsUtilities\WindowsUtilities\CheckNetworkCard.ps1 Ethernet 3100 1500
start powershell -File %USERPROFILE%\source\repos\WindowsUtilities\WindowsUtilities\CheckNetworkCard.ps1 Wi-Fi 3300 1650
REM needs to run as ADMIN due to tryinhg to restart the Adapter *if* it drops to 100Mbps
PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Unrestricted -File ""%USERPROFILE%\source\repos\WindowsUtilities\WindowsUtilities\CheckEthernetCardSpeed.ps1""' -Verb RunAs}";
REM PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Unrestricted -File ""%USERPROFILE%\source\repos\WindowsUtilities\WindowsUtilities\CheckNetworkCard.ps1 Wi-Fi 3200 1850""' -Verb RunAs}";

exit
