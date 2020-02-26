# Vivaldiが実行中の場合は何もしない
$process = Get-Process -Name vivaldi -ErrorAction SilentlyContinue
If ($process) {
    Exit
}

# 設定ファイルを取得
$preferences = Get-Content "C:\Users\test\AppData\Local\Vivaldi\User Data\Default\Preferences" -Encoding UTF8 | ConvertFrom-Json

# AdGuardを無効にする
If ($preferences.extensions.settings.bgnkhhnnamicmpeenaelnjfhikgbkllg.disable_reasons) {
    $preferences.extensions.settings.bgnkhhnnamicmpeenaelnjfhikgbkllg.disable_reasons = 1
} else {
    $preferences.extensions.settings.bgnkhhnnamicmpeenaelnjfhikgbkllg | Add-Member -MemberType NoteProperty -Name "disable_reasons" -Value 1
}
$preferences.extensions.settings.bgnkhhnnamicmpeenaelnjfhikgbkllg.state = 0

# 設定ファイルを保存
$preferences | ConvertTo-Json -Compress -Depth 10 | Out-File "C:\Users\test\AppData\Local\Vivaldi\User Data\Default\Preferences" -Encoding UTF8

# Vivaldiを起動
Start-Process -FilePath "C:\Program Files\Vivaldi\Application\vivaldi_proxy.exe" -ArgumentList "--profile-directory=Default","--app-id=mpognobbkildjkofajifpdfhcoklimli"
