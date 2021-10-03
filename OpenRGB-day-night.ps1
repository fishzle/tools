#
# If it's before sunset, load the bright keyboard.
# If it's after sunset, load the dim keyboard.
#
$oneDrivePath = $ENV:OneDriveConsumer;
$OPENRGB = "$oneDrivePath\bin\OpenRGB Windows 64-bit\openrgb.exe"

$BEFORE = "--noautoconnect --startminimized --profile first-day.orp"
$AFTER  = "--noautoconnect --startminimized --profile first-night.orp"


$Daylight = (Invoke-RestMethod "https://api.sunrise-sunset.org/json?lat=-33.8548157&lng=151.2164539&formatted=0").results
# $Sunrise  = ($Daylight.Sunrise | Get-Date -Format "HH:mm")
$Sunset   = ($Daylight.Sunset | Get-Date -Format "HH:mm")

$now = (get-date).ToString('T')


if ($now -lt $Sunset) {
    # before sunset
    $BEFORE = $BEFORE.Split(" ")
    start-process -NoNewWindow -filepath $OPENRGB -ArgumentList $BEFORE
    
    } else {   # after sunset
    $AFTER = $AFTER.Split(" ")
    start-process -NoNewWindow -filepath $OPENRGB -ArgumentList $AFTER
}

