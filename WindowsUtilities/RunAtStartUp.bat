@ECHO  OFF
CD C:\Users\shaun\source\repos\WindowsUtilities\WindowsUtilities

REM #
REM # Start IN-LINE programs
REM #
REM # Ensure latest virus definitions
start "Defender Update" "%ProgramFiles%\Windows Defender\MpCmdRun.exe" -SignatureUpdate
REM powershell Update-MpSignature
REM
REM # Start taskmanager window on Performance graphs tab
start %systemroot%\System32\taskmgr ignored /performance
REM # window move seems to FAIL - not sure why
REM for /f "tokens=2 USEBACKQ" %%f IN (`tasklist /NH /FI "IMAGENAME eq taskmgr.exe"`) Do powershell -File %USERPROFILE%\source\repos\WindowsUtilities\WindowsUtilities\MoveWindow.ps1 %%f 3070 1000 1735 500
REM #
REM # Start OWN-PROCESS programs
REM #

for /f %%a in ('wmic path win32_localtime get dayofweek /format:list ^| findstr "="') do set %%a
echo Day of week is %DayOfWeek%
if %DayOfWeek% gtr 0 if %DayOfWeek% lss 6 goto ok
choice /C YN /T 10 /D N /M "It's the Weekend, do you want these to run"
if %ERRORLEVEL% EQU 1 goto ok
exit 0
:ok


REM # pass random number from here, otherwise all the processes get the same one as based of clock-time seed

REM fire up all in the new windows terminal as multipane
echo "Starting Multipane..."
start StartMultiPane
echo "Starting Matplot Visualiser..."
start StartPingVisualiserMatplotlib.bat %random%
echo "Starting AppSheet Visualiser..."
start StartPingVisualiserAppSheet.bat

echo "Done"
EXIT 0


REM 
REM  If you ever wanted to kill all the tasks performing Ping Trending then this will do the job:
REM 
REM taskkill /fi "WINDOWTITLE eq Ping*"
