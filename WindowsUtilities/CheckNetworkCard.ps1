<# :
:: Check Ethernet & WiFi Card Speeds - 
:: 
#>

# Get passed argument - type-of-card
$card = $args[0]

# clear-host
$count_up_good = 0
$count_up_bad = 0
$count_disc = 0
$count_other = 0
$count_total = 0
$count_state = 0
$prevStatus = ""
$prevLinkSpeed = ""

$timestamp = Get-Date -format "yyyy-MMM-dd HH:mm:ss"
write-host $timestamp / NetWork Card Status Checker Started / Available Network Adapters
Get-NetAdapter
write-host "--"

Get-NetAdapter -Name $card | select InterfaceDescription -outvariable card_obj | Out-Null
write-host $timestamp / $card / $card_obj.InterfaceDescription
# If you want the windoe title changed... 
# $Host.UI.RawUI.WindowTitle = "Card Check: " + $card_obj.InterfaceDescription
	
while ($true) 
{
	$timestamp = Get-Date -format "yyyy-MMM-dd HH:mm:ss"
	Get-NetAdapter -Name $card | select Status, LinkSpeed -outvariable card_obj | Out-Null
	
	if (($prevStatus -ne $card_obj.Status) -or ($prevLinkSpeed -ne $card_obj.LinkSpeed)) {
		$prevStatus = $card_obj.Status
		$prevLinkSpeed = $card_obj.LinkSpeed
		$count_state = 0
		write-host ""
	}
	
	$count_total += 1
	$count_state += 1
	$fc = "White"
	$bc = "Black"

	if  ($card_obj.Status -eq "Up") 
	{
		if (($card -eq "Ethernet" -and $card_obj.LinkSpeed -eq "1 Gbps") -or ($card -eq "Wi-Fi" -and $card_obj.LinkSpeed -eq "866.7 Mbps"))
		{
			$count_up_good +=1 
			$fc = "Black"
			$bc = "Green"
			$statusGood = $true
		}
		else 
		{
			$count_up_bad +=1 
			$fc = "White"
			$bc = "Magenta"
			$statusGood = $false
		}
	}
	else 
	{
		$fc = "White"
		$bc = "Red"
		if  ($card_obj.Status -eq "Disconnected") 
		{
			$count_disc += 1
			#Get-NetAdapter -Name $card | Format-List -Property Operational*
		}
		else 
		{
			$count_other += 1
			#Get-NetAdapter -Name $card | Format-List -Property *
		}
	}
	# $msg1 = "Best " + ($count_up_good / $count_total * 100).tostring("#") + "% / OK " + ($count_up_bad / $count_total * 100).tostring("#") + "%"
	# $msg2 = "Down " + ($count_disc / $count_total * 100).tostring("#") + "% / Other " + ($count_other / $count_total * 100).tostring("#") + "%"
	$msg3 = "In state for " + [timespan]::fromseconds($count_state)
	write-host `r$timestamp / $card / $card_obj.Status / Speed: $card_obj.LinkSpeed / $msg3 -ForegroundColor $fc -BackgroundColor $bc -NoNewLine
	Start-Sleep -Seconds 1
}

write-host "FINISHED"
