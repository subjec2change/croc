@echo off
setlocal enabledelayedexpansion

REM Batch file to select a file or folder and send it using croc.exe
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
echo           croc File Sender
echo ========================================
echo.
echo Select what you want to send:
echo   1. File
echo   2. Folder
echo.
set /p "choice=Enter your choice (1 or 2): "

if "%choice%"=="1" goto selectfile
if "%choice%"=="2" goto selectfolder

echo Invalid choice. Please enter 1 or 2.
pause
exit /b 1

:selectfile
REM Use PowerShell to open file dialog
for /f "delims=" %%I in ('powershell -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; $dialog = New-Object System.Windows.Forms.OpenFileDialog; $dialog.Title = 'Select a file to send'; $dialog.Filter = 'All files (*.*)|*.*'; if ($dialog.ShowDialog() -eq 'OK') { $dialog.FileName } else { '' }"') do set "SELECTED=%%I"

if "!SELECTED!"=="" (
    echo No file selected. Exiting.
    pause
    exit /b 0
)

goto send

:selectfolder
REM Use PowerShell to open folder dialog
for /f "delims=" %%I in ('powershell -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; $dialog = New-Object System.Windows.Forms.FolderBrowserDialog; $dialog.Description = 'Select a folder to send'; if ($dialog.ShowDialog() -eq 'OK') { $dialog.SelectedPath } else { '' }"') do set "SELECTED=%%I"

if "!SELECTED!"=="" (
    echo No folder selected. Exiting.
    pause
    exit /b 0
)

goto send

:send
echo.
echo ========================================
echo Sending: !SELECTED!
echo ========================================
echo.

REM Run croc.exe from the script directory
"%SCRIPT_DIR%croc.exe" send "!SELECTED!"

echo.
echo ========================================
echo Transfer complete or cancelled.
echo ========================================
pause
