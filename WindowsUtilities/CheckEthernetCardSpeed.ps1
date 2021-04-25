<# :
:: Check Ethernet & WiFi Card Speeds - 
:: 
#>


# First, move this window someone useful...
# Expose the WIN32 explicit MoveWindow function
Add-Type @"
  using System;
  using System.Runtime.InteropServices;
  
  public class Win32 {
    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
  }
"@
# Get the window handler for this process
$h = (Get-Process -Id $PID).MainWindowHandle
# Move the window accord to parameters passed
# 3600 1850 1200 150
[Win32]::MoveWindow($h, 3500, 1850, 1300, 150, $true )


clear-host
$badCount = 0
$statusGood = $true

$timestamp = Get-Date -format "yyyy-MMM-dd HH:mm:ss"
write-host $timestamp / Ethernet Card Status Checker Started

while ($true) {
	$a = (Get-Host).UI.RawUI
	$timestamp = Get-Date -format "yyyy-MMM-dd HH:mm:ss"
	#Get-WmiObject -ComputerName 'XPS8930' -Class Win32_NetworkAdapter | Where-Object { $_.Name -eq $card } | select -ExpandProperty Speed -outvariable speed |  Out-Null
	Get-NetAdapter -Name Ethernet | select InterfaceDescription, Status, LinkSpeed -outvariable ethernet | Out-Null
	if  ($ethernet.LinkSpeed -eq "1 Gbps")
	{
		$a.BackgroundColor = "green"
		$a.ForegroundColor = "black"
		write-host -NoNewLine `r$timestamp / CARD: $ethernet.InterFaceDescription / $ethernet.Status / Speed: $ethernet.LinkSpeed / Bad=$badCount
		$statusGood = $true
	}
	else 
	{
		if ($statusGood) {write-host ""}
		$badCount = $badCount + 1
		$a.BackgroundColor = "red"
		$a.ForegroundColor = "white"
		write-host $timestamp / CARD: $ethernet.InterFaceDescription / $ethernet.Status / Speed: $ethernet.LinkSpeed / Bad=$badCount 
		$statusGood = $false
		# Check the WiFi
		# Get-NetAdapter -Name Wi-Fi | select InterfaceDescription, Status, LinkSpeed -outvariable wifi | Out-Null
		# write-host ">>>>" $timestamp / CARD: $wifi.InterFaceDescription / $wifi.Status / Speed: $wifi.LinkSpeed
	
		if ($ethernet.LinkSpeed -eq "100 Mbps") 
		{
			# PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Unrestricted -File ""PS_Script_Path&Name.ps1""' -Verb RunAs}"
			write-host ">>>  Attempting Ethernet Adapter Restart"
			# This next command needs to be running as Admin
			# TODO !!!
			try {Restart-NetAdapter -Name Ethernet}
			catch {
				read-host "ERROR: Unable to restart, please perform manually. Then press ENTER to continue"
			}
		}
	}
	Start-Sleep -Seconds 1
}

$a.BackgroundColor = "black"
$a.ForegroundColor = "white"
write-host "FINISHED"
