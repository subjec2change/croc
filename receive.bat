@echo off
setlocal enabledelayedexpansion

REM Batch file to receive files using croc.exe
REM This script should be placed in the same folder as croc.exe

REM Get the directory where this batch file is located
set "SCRIPT_DIR=%~dp0"

REM Check if croc.exe exists in the same directory
if not exist "%SCRIPT_DIR%croc.exe" (
    echo Error: croc.exe not found in %SCRIPT_DIR%
    echo Please ensure this batch file is in the same folder as croc.exe
    pause
    exit /b 1
)

echo ========================================
echo          croc File Receiver
echo ========================================
echo.
set /p "code=Enter the code phrase: "

if "!code!"=="" (
    echo No code phrase entered. Exiting.
    pause
    exit /b 0
)

echo.
echo ========================================
echo Receiving with code: !code!
echo ========================================
echo.

REM Run croc.exe from the script directory
"%SCRIPT_DIR%croc.exe" "!code!"

echo.
echo ========================================
echo Transfer complete or cancelled.
echo ========================================
pause
