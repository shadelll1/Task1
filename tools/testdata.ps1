# Тестовые данные BUH-214: сборка внешней обработки из tools\epf-src и запуск 1С:Предприятия с ней.
# Обработка при открытии создает покупателей, реализации и оплаты (однократно, повторный запуск ничего не дублирует).
# Журнал: окно сообщений 1С и файл %TEMP%\kd_testdata.log.
. "$PSScriptRoot\common.ps1"
Assert-Base

$xml = Join-Path $PSScriptRoot 'epf-src\кд_ТестовыеДанные.xml'
$buildDir = Join-Path $Root 'build'
if (-not (Test-Path -LiteralPath $buildDir)) { New-Item -ItemType Directory -Path $buildDir | Out-Null }
$epf = Join-Path $buildDir 'кд_ТестовыеДанные.epf'

Write-Host "[1/2] Сборка $epf ..."
$code = Invoke-Designer -LogName 'testdata.log' -CommandArgs @('/LoadExternalDataProcessorOrReportFromFiles', $xml, $epf)
if ($code -ne 0) { Write-Host "`n[ОШИБКА] Сборка обработки не удалась (код $code). Смотрите testdata.log"; exit 1 }

Write-Host '[2/2] Запуск 1С:Предприятия с обработкой ...'
$auth = @()
if ($ONEC_USER) { $auth = @('/N' + $ONEC_USER) }
$all = @('ENTERPRISE', '/F', $ONEC_FILEBASE_PATH) + $auth + @('/Execute', $epf)
Start-Process -FilePath $V8 -ArgumentList (Format-ArgList $all)
Write-Host '[OK] 1С запущена. Результат - в окне сообщений.'
exit 0
