@echo off
@echo off

echo Starting AppSheet Ping Trend window in Chrome

REM Starting chrome in new window; --window-size and --window-position parameters not recognised if chrome is already running
REM			--window-size="1400,800" 
REM			--window-position="0,0"
REM			--app=www.google.com		Opens the broswer in KIOSK mode without bookmarks bar
start "Ping Trend Appsheet" /b "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --new-window --app=https://www.appsheet.com/start/2aa910a9-b1bd-44e2-9caf-835da802c1bf

REM    now we have to wait a while until the WINDOW TITLE stablises
:waitPID
echo Waiting for AppSheet to complete load
timeout 5 > nul
for /f "tokens=2 USEBACKQ" %%f IN (`tasklist /NH /FI "IMAGENAME eq chrome.exe" /FI "WINDOWTITLE eq Ping Trend*"`) Do set myPID=%%f
if %myPID% equ No goto waitPID
echo Found window Process ID : %myPID%
powershell -File %USERPROFILE%\source\repos\WindowsUtilities\WindowsUtilities\MoveWindow.ps1 %myPID% 3075 1700 1725 500
exit