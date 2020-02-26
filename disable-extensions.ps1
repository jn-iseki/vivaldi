# Vivaldi�����s���̏ꍇ�͉������Ȃ�
$process = Get-Process -Name vivaldi -ErrorAction SilentlyContinue
If ($process) {
    Exit
}

# �ݒ�t�@�C�����擾
$preferences = Get-Content "C:\Users\test\AppData\Local\Vivaldi\User Data\Default\Preferences" -Encoding UTF8 | ConvertFrom-Json

# AdGuard�𖳌��ɂ���
If ($preferences.extensions.settings.bgnkhhnnamicmpeenaelnjfhikgbkllg.disable_reasons) {
    $preferences.extensions.settings.bgnkhhnnamicmpeenaelnjfhikgbkllg.disable_reasons = 1
} else {
    $preferences.extensions.settings.bgnkhhnnamicmpeenaelnjfhikgbkllg | Add-Member -MemberType NoteProperty -Name "disable_reasons" -Value 1
}
$preferences.extensions.settings.bgnkhhnnamicmpeenaelnjfhikgbkllg.state = 0

# �ݒ�t�@�C����ۑ�
$preferences | ConvertTo-Json -Compress -Depth 10 | Out-File "C:\Users\test\AppData\Local\Vivaldi\User Data\Default\Preferences" -Encoding UTF8

# Vivaldi���N��
Start-Process -FilePath "C:\Program Files\Vivaldi\Application\vivaldi_proxy.exe" -ArgumentList "--profile-directory=Default","--app-id=mpognobbkildjkofajifpdfhcoklimli"
