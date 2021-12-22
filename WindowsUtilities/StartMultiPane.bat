@echo off
REM CD %USERPROFILE%\PycharmProjects\pingTrend

REM #
REM # Start WINDOWS TERMINAL in MULTI-PANE mode for PING TREND
REM #

wt --window PingTrends --title "PingTrends CardSpeed"  --tabColor "#0F6307" -d "%USERPROFILE%\source\repos\WindowsUtilities\WindowsUtilities" powershell -File CheckNetworkCard.ps1 Ethernet ; ^
	sp -H --title "PingTrends RealTime"  --tabColor "#FF6347" --colorScheme "PingTrends" -s 0.66 -d "%USERPROFILE%\source\repos\WindowsUtilities\WindowsUtilities" StartPingLatency4.bat ; ^
	sp --title "PingTrends SQLite"  --tabColor "#00FF47" --colorScheme "Solarized Dark" -s 0.66 -d "%USERPROFILE%\PycharmProjects\pingTrend" python collect-sqlite.py ; ^
	sp -H --title "PingTrends Sheets"  --tabColor "#0F07FF"  --colorScheme "Tango Dark" -s 0.66 -d "%USERPROFILE%\PycharmProjects\pingTrend" python collect-sheets.py ; ^
	sp -H --title "PingTrends Title" --tabColor "#3F0ABA" --colorScheme "Vintage" powershell -NoExit Invoke-restMethod -Uri https://artii.herokuapp.com/make?text='..... PingTrends .....' ; ^
	move-focus left 

REM # Need to wait for the WT setup to complete....
:getPID   
for /f "tokens=2 USEBACKQ" %%f IN (`tasklist /NH /FI "WINDOWTITLE eq PingTrends*"`) do set myPID=%%f
if %myPID% equ No goto getPID

REM # ... then move window to desired place
powershell -File %USERPROFILE%\source\repos\WindowsUtilities\WindowsUtilities\MoveWindow.ps1 %myPID% 3075 1000 1725 700

REM If you need to run powershell in ADMIN mode (ie to restart the adapter) then needs somehting elike this:
REM PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Unrestricted -File ""%USERPROFILE%\source\repos\WindowsUtilities\WindowsUtilities\CheckEthernetCardSpeed.ps1""' -Verb RunAs}";





exit 