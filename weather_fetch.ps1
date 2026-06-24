# weather_fetch.ps1

$outputFile = "C:\Users\yongw\claude-workplace\weather.txt"
$date = Get-Date -Format "yyyy-MM-dd HH:mm"

# --- 날씨 (wttr.in) ---
try {
    $w = Invoke-RestMethod -Uri "https://wttr.in/Gangnam,Seoul?format=j1" -TimeoutSec 15
    $c = $w.current_condition[0]
    $temp      = $c.temp_C
    $feelsLike = $c.FeelsLikeC
    $humidity  = $c.humidity
    $windSpeed = $c.windspeedKmph
    $desc      = $c.weatherDesc[0].value
} catch {
    $temp = "?"; $feelsLike = "-"; $humidity = "-"; $windSpeed = "-"
    $desc = "weather fetch failed"
}

# --- 미세먼지 (WAQI demo) ---
try {
    $a = Invoke-RestMethod -Uri "https://api.waqi.info/feed/seoul/?token=demo" -TimeoutSec 15
    $aqi  = $a.data.aqi
    $pm25 = $a.data.iaqi.pm25.v
    $pm10 = $a.data.iaqi.pm10.v
} catch {
    $aqi = "?"; $pm25 = $null; $pm10 = $null
}

function Get-PM25Grade($v) {
    if ($null -eq $v) { return "알수없음" }
    $n = [double]$v
    if ($n -le 15)  { return "좋음" }
    elseif ($n -le 35) { return "보통" }
    elseif ($n -le 75) { return "나쁨" }
    else               { return "매우나쁨" }
}

function Get-PM10Grade($v) {
    if ($null -eq $v) { return "알수없음" }
    $n = [double]$v
    if ($n -le 30)   { return "좋음" }
    elseif ($n -le 80)  { return "보통" }
    elseif ($n -le 150) { return "나쁨" }
    else                { return "매우나쁨" }
}

$pm25Grade = Get-PM25Grade $pm25
$pm10Grade = Get-PM10Grade $pm10
$pm25Str   = if ($null -ne $pm25) { "$pm25 ug/m3" } else { "조회실패" }
$pm10Str   = if ($null -ne $pm10) { "$pm10 ug/m3" } else { "조회실패" }

$entry = "========================================`r`n"
$entry += "  서울 강남구 날씨 & 미세먼지`r`n"
$entry += "  조회 시각: $date`r`n"
$entry += "========================================`r`n"
$entry += "[날씨]`r`n"
$entry += "  상태   : $desc`r`n"
$entry += "  기온   : ${temp}C  (체감 ${feelsLike}C)`r`n"
$entry += "  습도   : ${humidity}%`r`n"
$entry += "  풍속   : ${windSpeed} km/h`r`n"
$entry += "`r`n"
$entry += "[미세먼지]`r`n"
$entry += "  PM2.5  : $pm25Str  -> $pm25Grade`r`n"
$entry += "  PM10   : $pm10Str  -> $pm10Grade`r`n"
$entry += "  AQI    : $aqi`r`n"
$entry += "========================================`r`n`r`n"

$existing = if (Test-Path $outputFile) { Get-Content $outputFile -Raw -Encoding UTF8 } else { "" }
[System.IO.File]::WriteAllText($outputFile, ($entry + $existing), [System.Text.Encoding]::UTF8)

Write-Host "완료: $outputFile 저장"