@echo off
REM ============================================
REM COSMO Personal Prompts - Shortcut Creator
REM ============================================
REM Creates desktop and Start Menu shortcuts to local COSMO prompts folder
REM Run this script once to set up quick access

setlocal enabledelayedexpansion

REM Define paths
set PROMPT_DIR=C:\Users\%USERNAME%\Documents\COSMO-Prompts
set DESKTOP=%USERPROFILE%\Desktop
set STARTMENU=%APPDATA%\Microsoft\Windows\Start Menu\Programs

echo Creating COSMO Prompts shortcuts...
echo.

REM Create prompts directory if it doesn't exist
if not exist "%PROMPT_DIR%" (
  mkdir "%PROMPT_DIR%"
  echo Created directory: %PROMPT_DIR%
) else (
  echo Directory already exists: %PROMPT_DIR%
)

echo.
echo Creating shortcuts...
echo.

REM Create shortcuts using PowerShell
powershell -Command "
$WshShell = New-Object -ComObject WScript.Shell

# Desktop shortcut
$DesktopShortcut = $WshShell.CreateShortcut('%DESKTOP%\COSMO-Prompts.lnk')
$DesktopShortcut.TargetPath = '%PROMPT_DIR%'
$DesktopShortcut.Description = 'COSMO Personal Prompts - Local Access'
$DesktopShortcut.Save()
Write-Host 'Desktop shortcut created: COSMO-Prompts.lnk'

# Start Menu shortcut
$StartMenuShortcut = $WshShell.CreateShortcut('%STARTMENU%\COSMO-Prompts.lnk')
$StartMenuShortcut.TargetPath = '%PROMPT_DIR%'
$StartMenuShortcut.Description = 'COSMO Personal Prompts - Local Access'
$StartMenuShortcut.Save()
Write-Host 'Start Menu shortcut created: COSMO-Prompts.lnk'
"

echo.
echo ============================================
echo Setup Complete!
echo ============================================
echo.
echo Desktop shortcut: %DESKTOP%\COSMO-Prompts.lnk
echo Start Menu shortcut: %STARTMENU%\COSMO-Prompts.lnk
echo Local folder: %PROMPT_DIR%
echo.
echo Place your personal prompt files in: %PROMPT_DIR%
echo.
pause
