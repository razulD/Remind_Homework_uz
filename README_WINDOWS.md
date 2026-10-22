# Homework Reminder (Windows 10/11 Edition)

A lightweight, completely silent local homework tracker with automatic hourly Windows Action Center reminders.

---

## Prerequisite (One-Time Check)
Make sure **Python 3** is installed on your PC:
1. If you don't have Python installed, download it from [python.org](https://www.python.org/downloads/).
2. **Important:** On the first screen of the Python installer, check the box at the bottom that says **"Add python.exe to PATH"** before clicking Install.

---

## How to Install (One Click)

1. Extract or place this entire folder anywhere you want to keep it permanently (for example, `C:\Users\YourName\Documents\HomeworkReminder`).
2. Double-click **`setup.bat`**.
3. If Windows asks *"Do you want to allow this app to make changes to your device?"*, click **Yes**.
4. Wait about 15–30 seconds while the installer sets everything up. Your web browser will automatically open to your **Homework Manager** dashboard (`http://127.0.0.1:5000`).

---

## How It Works

* **Always On, Zero Clutter:** The web dashboard runs invisibly in the background whenever you turn on your PC. There are no command prompt windows to keep open.
* **Accessing Your Dashboard:** Bookmark **`http://127.0.0.1:5000`** in your browser to add or complete homework at any time.
* **Smart Reminders:**
  * **1 minute after starting your PC**, Windows checks your list and pops up a notification if you have unfinished homework.
  * **Every hour on the hour** (1:00, 2:00, 3:00, etc.), you will get a reminder in the bottom-right corner (and in your Windows Action Center) if you still have active tasks.
  * Clicking **"Open Dashboard"** on any notification opens your homework list immediately.
  * If all your homework is marked **Done**, the app stays completely silent.

---

## Important Note About Moving the Folder
If you ever move this folder to a different location on your computer, simply double-click **`setup.bat`** again so Windows updates the folder path. Your saved homework inside `homework.json` will not be lost.

---

## How to Uninstall
If you ever want to stop the automatic reminders and background server, open **Command Prompt** and paste these three lines:

```cmd
schtasks /Delete /TN "HomeworkReminder_Server" /F
schtasks /Delete /TN "HomeworkReminder_BootNotify" /F
schtasks /Delete /TN "HomeworkReminder_HourlyNotify" /F
