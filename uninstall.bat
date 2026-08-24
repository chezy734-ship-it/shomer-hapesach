@echo off
chcp 65001 >nul 2>&1
title Shomer HaPetach - Uninstall
echo ============================================
echo   Shomer HaPetach - Uninstall
echo ============================================
echo.

:: Step 1: Release Ctrl+Alt+Del and system locks
echo [1/4] Releasing system locks (Ctrl+Alt+Del, Task Manager, etc.)...

:: HKCU Explorer policies
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoLogoff" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoClose" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoWinKeys" /f >nul 2>&1

:: HKCU System policies
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableLockWorkstation" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableTaskMgr" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableChangePassword" /f >nul 2>&1

:: HKLM System policies (requires admin)
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "HideFastUserSwitching" /f >nul 2>&1
echo [OK] System locks released

:: Step 2: Remove startup entry
echo [2/4] Removing startup entry...
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "ShomerHaPetach" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "ShomerHaPetach" /f >nul 2>&1
echo [OK] Startup entry removed

:: Step 3: Stop running processes
echo [3/4] Stopping running processes...
taskkill /IM "ShomerHaPetach.exe" /F >nul 2>&1
taskkill /IM "main.py" /F >nul 2>&1
echo [OK] Processes stopped

:: Step 4: Remove shortcuts
echo [4/4] Removing shortcuts...
if exist "%USERPROFILE%\Desktop\Shomer-HaPetach.lnk" (
    del "%USERPROFILE%\Desktop\Shomer-HaPetach.lnk" 2>nul
    echo [OK] Desktop shortcut removed
)
if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Shomer-HaPetach.lnk" (
    del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Shomer-HaPetach.lnk" 2>nul
    echo [OK] Start Menu shortcut removed
)

echo.
echo ============================================
echo   All registry changes have been reverted.
echo   Ctrl+Alt+Del and Task Manager are unlocked.
echo   The application folder will NOT be deleted.
echo   To fully remove, delete this folder manually:
echo     %~dp0
echo ============================================
echo.
pause
