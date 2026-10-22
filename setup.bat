@echo off
setlocal EnableDelayedExpansion
title Homework Reminder - One-Click Windows Setup

:: ---------------------------------------------------------------------------
:: 1. Self-Elevate to Administrator (Required by schtasks for boot triggers)
:: ---------------------------------------------------------------------------
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting Administrator privileges to configure Windows Task Scheduler...
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:: Anchor working directory to the folder containing setup.bat
cd /d "%~dp0"
set "APP_DIR=%~dp0"
set "VENV_DIR=%APP_DIR%venv"
set "PYTHONW_EXE=%VENV_DIR%\Scripts\pythonw.exe"
set "PYTHON_EXE=%VENV_DIR%\Scripts\python.exe"
set "HW_SCRIPT=%APP_DIR%hw.py"
set "NOTIFIER_SCRIPT=%APP_DIR%notifier.py"

echo ========================================================
echo   Homework Reminder - Automatic Windows Installer
echo ========================================================
echo.

:: ---------------------------------------------------------------------------
:: 2. Verify Python Installation
:: ---------------------------------------------------------------------------
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python was not found in your Windows PATH.
    echo Please install Python 3 from https://www.python.org/downloads/
    echo IMPORTANT: Check the box "Add python.exe to PATH" during installation.
    pause
    exit /b 1
)

:: ---------------------------------------------------------------------------
:: 3. Create Virtual Environment & Install Dependencies
:: ---------------------------------------------------------------------------
if not exist "%VENV_DIR%\Scripts\python.exe" (
    echo [1/4] Creating Python virtual environment...
    python -m venv "%VENV_DIR%"
    if %errorlevel% neq 0 (
        echo [ERROR] Failed to create virtual environment.
        pause
        exit /b 1
    )
) else (
    echo [1/4] Virtual environment already exists.
)

echo [2/4] Installing required packages (Flask, winotify, plyer)...
"%PYTHON_EXE%" -m pip install --upgrade pip --quiet
"%PYTHON_EXE%" -m pip install -r "%APP_DIR%requirements.txt" --quiet
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install dependencies from requirements.txt.
    pause
    exit /b 1
)

:: ---------------------------------------------------------------------------
:: 4. Register Background Tasks in Windows Task Scheduler (schtasks)
:: ---------------------------------------------------------------------------
echo [3/4] Registering silent background tasks in Windows Task Scheduler...

:: Task A: Start Flask server silently on boot/logon
schtasks /Create /TN "HomeworkReminder_Server" /TR "\"%PYTHONW_EXE%\" \"%HW_SCRIPT%\"" /SC ONLOGON /RL LIMITED /IT /F >nul

:: Task B: Run notifier 1 minute after boot/logon (/DELAY 0001:00 = 1 min)
schtasks /Create /TN "HomeworkReminder_BootNotify" /TR "\"%PYTHONW_EXE%\" \"%NOTIFIER_SCRIPT%\"" /SC ONLOGON /DELAY 0001:00 /RL LIMITED /IT /F >nul

:: Task C: Run notifier every hour on the hour (starting at 00:00)
schtasks /Create /TN "HomeworkReminder_HourlyNotify" /TR "\"%PYTHONW_EXE%\" \"%NOTIFIER_SCRIPT%\"" /SC HOURLY /MO 1 /ST 00:00 /RL LIMITED /IT /F >nul

:: ---------------------------------------------------------------------------
:: 5. Start the Background Server Immediately & Open Dashboard
:: ---------------------------------------------------------------------------
echo [4/4] Starting background server and launching web dashboard...

:: Stop any previous instance of hw.py before starting fresh
powershell -NoProfile -Command "Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'pythonw.exe' -and $_.CommandLine -like '*hw.py*' } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }" >nul 2>&1

:: Launch Flask invisibly via pythonw.exe
start "" "%PYTHONW_EXE%" "%HW_SCRIPT%"

:: Trigger an initial notification check
start "" "%PYTHONW_EXE%" "%NOTIFIER_SCRIPT%"

:: Wait 2 seconds for Flask to bind to port 5000, then open default browser
timeout /t 2 /nobreak >nul
start "" "http://127.0.0.1:5000"

echo.
echo ========================================================
echo   SUCCESS! Homework Reminder is installed and running.
echo   Dashboard URL: http://127.0.0.1:5000
echo ========================================================
echo You can now close this window.
pause
