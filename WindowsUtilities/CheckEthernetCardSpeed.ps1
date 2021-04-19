<# :
:: Check Ethernet & WiFi Card Speeds - 
:: 
#>


clear-host
$badCount = 0
$statusGood = $true

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
			Restart-NetAdapter -Name Ethernet
		}
	}
	Start-Sleep -Seconds 1
}

$a.BackgroundColor = "black"
$a.ForegroundColor = "white"
write-host "FINISHED"
