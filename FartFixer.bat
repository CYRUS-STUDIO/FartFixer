@echo off
setlocal enabledelayedexpansion

REM ����Ƿ��ṩ����������
if "%~2"=="" (
    echo �÷�: ���� dex �ļ� �� bin �ļ�����ͨ�������д���
    echo ʾ��: FartFixer.bat D:\classes.dex D:\code_item.bin
    pause
    exit /b
)

REM ��ȡ����
set "DEX_PATH=%~1"
set "BIN_PATH=%~2"

REM ��ȡ dex �ļ�����Ŀ¼���ļ���
for %%F in ("%DEX_PATH%") do (
    set "DEX_DIR=%%~dpF"
    set "DEX_NAME=%%~nF"
)

REM �������·��
set "OUT_PATH=%DEX_DIR%%DEX_NAME%_fix.dex"

REM ִ������
java -jar "%~dp0FartFixer.jar" "%DEX_PATH%" "%BIN_PATH%" "%OUT_PATH%"

echo.
echo �޸���ɣ�����ļ�: %OUT_PATH%
pause
