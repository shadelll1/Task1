# База -> build\БП_КонтрольДолгов.cfe: выгрузка расширения в бинарный файл для сдачи.
# Сначала load.bat (чтобы в базе была актуальная версия из src), потом этот скрипт.
. "$PSScriptRoot\common.ps1"
Assert-Base

$buildDir = Join-Path $Root 'build'
if (-not (Test-Path -LiteralPath $buildDir)) { New-Item -ItemType Directory -Path $buildDir | Out-Null }
$cfe = Join-Path $buildDir ($EXT_NAME + '.cfe')

Write-Host "Выгрузка расширения «$EXT_NAME» в $cfe ..."
$code = Invoke-Designer -LogName 'build.log' -CommandArgs @('/DumpCfg', $cfe, '-Extension', $EXT_NAME)
if ($code -ne 0) { Write-Host "`n[ОШИБКА] Выгрузка .cfe не удалась (код $code). Смотрите build.log"; exit 1 }
Write-Host "`n[OK] $cfe"
exit 0
