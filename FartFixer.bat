@echo off
setlocal enabledelayedexpansion

:: ���� bin �ļ�Ŀ¼
set /p BIN_DIR=������ bin �ļ�����Ŀ¼:

:: �ж�Ŀ¼�Ƿ����
if not exist "%BIN_DIR%" (
    echo ����Ŀ¼ %BIN_DIR% ������
    pause
    exit /b
)

:: ���� bin �ļ�
for %%B in ("%BIN_DIR%\*.bin") do (
    set "BIN_FILE=%%~nxB"
    set "PREFIX="
    set "BIN_PATH=%%~fB"

    :: ��ȡǰ׺������ 11994176_
    for /f "tokens=1 delims=_" %%P in ("%%~nB") do (
        set "PREFIX=%%P_"
    )

    :: ����ƥ��� dex �ļ�
    for %%D in ("%BIN_DIR%\!PREFIX!*.dex") do (
        set "DEX_FILE=%%~nxD"
        set "DEX_PATH=%%~fD"

        :: ���� fix Ŀ¼
        set "FIX_DIR=%%~dpDfix"
        if not exist "!FIX_DIR!" (
            mkdir "!FIX_DIR!"
        )

        :: �������·��
        set "FIXED_DEX=!FIX_DIR!\!DEX_FILE:_file=_file_fix!"

        echo �޸� !DEX_FILE!��ʹ�� !BIN_FILE! ...
        java -jar ./FartFixer.jar "!DEX_PATH!" "!BIN_PATH!" "!FIXED_DEX!"
    )
)

echo ȫ���޸���ɡ�
pause