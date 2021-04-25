@ECHO  OFF
CD C:\Users\shaun\source\repos\WindowsUtilities\WindowsUtilities

REM #
REM # Start IN-LINE programs
REM #
REM # Ensure latest virus definitions
start "Defender Update" "%ProgramFiles%\Windows Defender\MpCmdRun.exe" -SignatureUpdate
REM
REM # Start taskmanager window on Performance graphs tab
start %systemroot%\System32\taskmgr ignored /performance
REM # window move seems to FAIL - not sure why
REM for /f "tokens=2 USEBACKQ" %%f IN (`tasklist /NH /FI "IMAGENAME eq taskmgr.exe"`) Do powershell -File %USERPROFILE%\source\repos\WindowsUtilities\WindowsUtilities\MoveWindow.ps1 %%f 3100 1000 900 700
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


REM # Fire up DBRAS as a new chrome window
start "DB RAS" /b "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --new-window --app=https://dbrasweb.db.com/


REM # pass random number from here, otherwise all the processes get the same one as based of clock-time seed
start StartPingLatency4.bat %random%
start StartPingCollectorAppSheet.bat %random%
start StartPingCollectorSQLite.bat %random%
start StartPingVisualiserMatplotlib.bat %random%
start StartPingVisualiserAppSheet.bat
start CheckEthernetCardSpeed.bat %random%

EXIT


REM 
REM  If you ever wanted to kill all the tasks performing Ping Trending then this will do the job:
REM 
REM taskkill /fi "WINDOWTITLE eq Ping*"
