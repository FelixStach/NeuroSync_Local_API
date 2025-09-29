@echo off
setlocal

echo ========================================================
echo Checking for Python installation...
echo ========================================================

where python >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Python is not installed or not added to PATH.
    echo Please install Python 3.10+ and add it to your PATH.
    pause
    exit /b 1
)

echo Python found!
python --version

echo.
echo ========================================================
echo Ensuring PyInstaller is installed...
echo ========================================================
python -m pip show pyinstaller >nul 2>nul
if %errorlevel% neq 0 (
    echo PyInstaller not found, installing...
    python -m pip install pyinstaller
    if %errorlevel% neq 0 (
        echo [ERROR] Failed to install PyInstaller.
        pause
        exit /b 1
    )
)

echo PyInstaller is available!

echo.
echo ========================================================
echo Cleaning old build/dist folders...
echo ========================================================
rmdir /s /q build 2>nul
rmdir /s /q dist 2>nul

echo.
echo ========================================================
echo Building executable with PyInstaller...
echo ========================================================
python -m PyInstaller --onefile ^
    --name NeuroSyncServer ^
    --icon server.ico ^
    neurosync_local_api.py

if %errorlevel% neq 0 (
    echo [ERROR] PyInstaller build failed!
    pause
    exit /b 1
)

echo.
echo ========================================================
echo Build complete!
echo The executable is located at:
echo   dist\NeuroSyncServer.exe
echo ========================================================
pause
endlocal