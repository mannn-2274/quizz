# Cài Quizz: cài Claude Code (nếu chưa có), đăng nhập bằng tài khoản Claude CỦA BẠN, tạo shortcut.
# Chạy: chuột phải thư mục -> Open in Terminal, rồi gõ:  powershell -ExecutionPolicy Bypass -File .\install.ps1
$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [Text.Encoding]::UTF8
$here = $PSScriptRoot

function Find-Claude {
    $cmd = Get-Command claude -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }
    $exe = "$env:USERPROFILE\.local\bin\claude.exe"  # nơi bộ cài chính thức đặt claude.exe (không tự thêm vào PATH)
    if (Test-Path $exe) { return $exe }
    return $null
}

# PS 5.1 + ErrorActionPreference=Stop biến stderr của chương trình ngoài thành lỗi dừng script -> tạm tắt
function Test-Login { $ErrorActionPreference = 'Continue'; & $claude auth status *> $null; return $LASTEXITCODE -eq 0 }

function Fail($msg) { Write-Host $msg -ForegroundColor Red; Read-Host 'Enter để thoát'; exit 1 }

Write-Host '1/3 Kiểm tra Claude Code...' -ForegroundColor Cyan
$claude = Find-Claude
if (-not $claude) {
    Write-Host '    Chưa có -> cài bản chính thức từ claude.ai ...'
    Invoke-RestMethod https://claude.ai/install.ps1 | Invoke-Expression
    $claude = Find-Claude
    if (-not $claude) { Fail 'Cài Claude Code thất bại. Xem: https://code.claude.com/docs/en/setup' }
}
Write-Host "    OK: $claude"

Write-Host '2/3 Kiểm tra đăng nhập...' -ForegroundColor Cyan
if (-not (Test-Login)) {
    Write-Host '    Chưa đăng nhập. Trình duyệt sẽ mở: đăng nhập tài khoản Claude (Pro/Max/Team) CỦA BẠN.' -ForegroundColor Yellow
    $ErrorActionPreference = 'Continue'; & $claude auth login; $ErrorActionPreference = 'Stop'
    if (-not (Test-Login)) { Fail 'Chưa đăng nhập được. Chạy lại install.ps1 để thử lại.' }
}
Write-Host '    OK: đã đăng nhập'

Write-Host '3/3 Tạo shortcut "Quizz" ở Desktop và Start Menu...' -ForegroundColor Cyan
Get-ChildItem $here -Recurse -File | Unblock-File  # bỏ cờ "tải từ Internet" của file zip
$shell = New-Object -ComObject WScript.Shell
foreach ($dir in [Environment]::GetFolderPath('Desktop'), [Environment]::GetFolderPath('Programs')) {
    $lnk = $shell.CreateShortcut("$dir\Quizz.lnk")
    $lnk.TargetPath = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"
    $lnk.Arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$here\quizz.ps1`""
    $lnk.WorkingDirectory = $here
    $lnk.IconLocation = "$env:SystemRoot\System32\imageres.dll,76"
    $lnk.Description = 'Quizz - F8/F9 giải câu đố mẹo trên màn hình'
    $lnk.Save()
}

Write-Host ''
Write-Host 'Xong! Mở "Quizz" trên Desktop. F8 = nhanh, F9 = suy luận sâu. Đáp án tự copy, Ctrl+V để dán.' -ForegroundColor Green
Write-Host 'Nhiều màn hình? Sửa shortcut thêm  -Screen 2  vào cuối ô Target để đọc màn hình 2.'
Read-Host 'Enter để đóng'
