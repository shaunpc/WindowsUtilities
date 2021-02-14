@ECHO  OFF
CD C:\Users\shaun\source\repos\WindowsUtilities\WindowsUtilities

REM #
REM # Start IN-LINE programs
REM #
start "Defender Update" "%ProgramFiles%\Windows Defender\MpCmdRun.exe" -SignatureUpdate
start %systemroot%\System32\taskmgr
REM #
REM # Start OWN-PROCESS programs
REM #

for /f %%a in ('wmic path win32_localtime get dayofweek /format:list ^| findstr "="') do set %%a
echo Day of week is %DayOfWeek%
if %DayOfWeek% gtr 0 if %DayOfWeek% lss 6 goto ok
choice /C YN /T 10 /D N /M "It's the Weekend, do you want these to run"
if %ERRORLEVEL% EQU 1 goto ok
exit
:ok

REM # pass random number from here, otherwise all the processes get the same one as based of clock-time seed
start StartPingLatency4.bat %random%
start StartPingCollectorAppSheet.bat %random%
start StartPingCollectorSQLite.bat %random%
start StartPingVisualiserMatplotlib.bat %random%

start "PingTrend Appsheet Visualiser" /b "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://www.appsheet.com/start/2aa910a9-b1bd-44e2-9caf-835da802c1bf

EXIT
