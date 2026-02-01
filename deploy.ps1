# --- 变量配置 ---
$WinConfDir = "$env:AppData\Rime"
$ConfigPath = "config"
$WubiConfigPath = "config/wubi"
$PinyinConfigPath = "config/pinyin"
$WindowsPath = "windows"

# --- 执行 Common (Git Submodule) ---
Write-Host "Updating git submodules..." -ForegroundColor Cyan
git submodule update --init

# --- 检查并创建目标目录 ---
if (-not (Test-Path $WinConfDir)) {
    Write-Host "Creating Rime directory: $WinConfDir" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $WinConfDir -Force
}

# --- 文件拷贝逻辑 ---
# 定义需要拷贝的任务列表
$CopyTasks = @(
    @{ Source = "$ConfigPath\*.yaml", "$ConfigPath\*.lua", "$ConfigPath\*.txt" },
    @{ Source = "$WubiConfigPath\*.yaml" },
    @{ Source = "$PinyinConfigPath\*.yaml" },
    @{ Source = "$WindowsPath\*" }
)

Write-Host "Deploying files to $WinConfDir..." -ForegroundColor Green

foreach ($Task in $CopyTasks) {
    foreach ($Pattern in $Task.Source) {
        if (Test-Path $Pattern) {
            Copy-Item -Path $Pattern -Destination $WinConfDir -Force -Verbose
        }
    }
}


