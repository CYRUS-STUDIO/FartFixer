@echo off
setlocal enabledelayedexpansion

REM 检查是否提供了两个参数
if "%~2"=="" (
    echo 用法: 拖入 dex 文件 和 bin 文件，或通过命令行传参
    echo 示例: FartFixer.bat D:\classes.dex D:\code_item.bin
    pause
    exit /b
)

REM 读取参数
set "DEX_PATH=%~1"
set "BIN_PATH=%~2"

REM 获取 dex 文件所在目录和文件名
for %%F in ("%DEX_PATH%") do (
    set "DEX_DIR=%%~dpF"
    set "DEX_NAME=%%~nF"
)

REM 构造输出路径
set "OUT_PATH=%DEX_DIR%%DEX_NAME%_fix.dex"

REM 执行命令
java -jar "%~dp0FartFixer.jar" "%DEX_PATH%" "%BIN_PATH%" "%OUT_PATH%"

echo.
echo 修复完成，输出文件: %OUT_PATH%
pause
