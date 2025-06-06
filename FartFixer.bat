@echo off
setlocal enabledelayedexpansion

:: 输入 bin 文件目录
set /p BIN_DIR=请输入 bin 文件所在目录:

:: 判断目录是否存在
if not exist "%BIN_DIR%" (
    echo 错误：目录 %BIN_DIR% 不存在
    pause
    exit /b
)

:: 遍历 bin 文件
for %%B in ("%BIN_DIR%\*.bin") do (
    set "BIN_FILE=%%~nxB"
    set "PREFIX="
    set "BIN_PATH=%%~fB"

    :: 提取前缀，比如 11994176_
    for /f "tokens=1 delims=_" %%P in ("%%~nB") do (
        set "PREFIX=%%P_"
    )

    :: 查找匹配的 dex 文件
    for %%D in ("%BIN_DIR%\!PREFIX!*.dex") do (
        set "DEX_FILE=%%~nxD"
        set "DEX_PATH=%%~fD"

        :: 创建 fix 目录
        set "FIX_DIR=%%~dpDfix"
        if not exist "!FIX_DIR!" (
            mkdir "!FIX_DIR!"
        )

        :: 构造输出路径
        set "FIXED_DEX=!FIX_DIR!\!DEX_FILE:_file=_file_fix!"

        echo 修复 !DEX_FILE!，使用 !BIN_FILE! ...
        java -jar ./FartFixer.jar "!DEX_PATH!" "!BIN_PATH!" "!FIXED_DEX!"
    )
)

echo 全部修复完成。
pause