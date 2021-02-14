@echo off

for /f %%a in ('wmic path win32_localtime get dayofweek /format:list ^| findstr "="') do set %%a
echo Day of week is %DayOfWeek%
if %DayOfWeek% gtr 0 if %DayOfWeek% lss 6 goto ok
choice /C YN /T 10 /D N /M "It's the Weekend, do you want this to run"
if %ERRORLEVEL% EQU 1 goto ok
exit
:ok

color 0D
start "PingTrend Appsheet Visualiser" /b "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://www.appsheet.com/start/2aa910a9-b1bd-44e2-9caf-835da802c1bf