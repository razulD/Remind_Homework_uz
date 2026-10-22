# Homework Reminder // Uy Vazifalari Eslatmasi

[English](#english) | [O'zbekcha](#ozbekcha)

---

<a name="english"></a>
## 🇬🇧 English Documentation

A lightweight, completely silent local homework tracker built for Windows 10/11, featuring automatic hourly Windows Action Center reminders and an instant language switcher (**EN / UZ**).

### 🚀 How to Install & Run (Everything You Need)

Follow these simple steps to get the app running on Windows:

1. **Prerequisite:** Make sure [Python 3](https://www.python.org/downloads/) is installed on your computer. **Important:** Check the box during installation that says **"Add python.exe to PATH"**.
2. **Download Project:** Extract or place your `Remind_Homework_uz` folder anywhere permanent on your PC (e.g., inside Documents).
3. **Run the Installer:** Double-click **`setup.bat`**. 
   * *What setup.bat does automatically:* It creates a secure Python virtual environment (`venv`), installs all required packages (`Flask`, `winotify`, `plyer`), registers silent background tasks in **Windows Task Scheduler**, starts the Flask server invisibly in the background, and automatically opens your web browser to `http://127.0.0.1:5000`.

### 💡 Daily Usage & Features
- **Web Dashboard:** Access your task manager anytime by opening **`http://127.0.0.1:5000`** in your browser.
- **Language Switcher:** Click the **EN / UZ** buttons at the top right of the web page to instantly switch languages.
- **Automatic Notifications:** 
  - You receive a notification **1 minute after booting your PC** if you have pending tasks.
  - You get an update **every hour on the hour** if active homework remains.
  - Clicking "Open Dashboard" on any notification immediately brings up your task list.
  - If all homework is marked **Done**, the application stays completely silent.

### 🗑️ How to Uninstall / Stop Background Tasks
If you want to completely remove the scheduled background tasks, open **Command Prompt** and paste:
```cmd
schtasks /Delete /TN "HomeworkReminder_Server" /F
schtasks /Delete /TN "HomeworkReminder_BootNotify" /F
schtasks /Delete /TN "HomeworkReminder_HourlyNotify" /F
```

---

<a name="ozbekcha"></a>
## 🇺🇿 O'zbekcha Qo'llanma

Windows 10/11 uchun mo'ljallangan, orqa fonda jim ishlovchi yengil uy vazifalari nazorati va har soatda Windows bildirishnomalari (Action Center) orqali eslatib turuvchi dastur. Ikki tilli (EN / UZ) interfeysni qo'llab-quvvatlaydi.

### 🚀 O'rnatish va Ishga Tushirish (To'liq qo'llanma)

Dasturni kompyuterda ishga tushirish uchun quyidagi qadamlarni bajaring:

1. **Talab:** Kompyuteringizda [Python 3](https://www.python.org/downloads/) o'rnatilgan bo'lishi kerak. **Muhim:** O'rnatish jarayonida **"Add python.exe to PATH"** katakchasiga belgi qo'ying.
2. **Papkani joylash:** `Remind_Homework_uz` papkasini kompyuteringizda doimiy turadigan joyga qo'ying (masalan, Documents'ga).
3. **O'rnatuvchini ishga tushirish:** **`setup.bat`** fayli ustiga sichqoncha bilan ikki marta bosing.
   * *`setup.bat` nima qiladi?* U avtomatik ravishda Python muhitini (`venv`) yaratadi, kerakli paketlarni (`Flask`, `winotify`, `plyer`) o'rnatadi, Windows Task Scheduler'ga orqa fonda ishlaydigan vazifalarni qo'shadi, serverni ishga tushiradi va brauzeringizda `http://127.0.0.1:5000` manzilini ochadi.

### 💡 Kundalik Foydalanish va Imkoniyatlar

- **Boshqaruv paneli:** Vazifalarni boshqarish uchun istalgan vaqtda brauzeringizda **`http://127.0.0.1:5000`** manzilini oching.
- **Tilni o'zgartirish:** Sahifaning yuqori o'ng burchagidagi **EN / UZ** tugmalarini bosib tildan tilga o'ting.
- **Avtomatik eslatmalar:**
    - Kompyuter yongandan **1 daqiqa o'tib** bajarilmagan vazifalar haqida xabar chiqadi.
    - Har soat boshida agar bajarilmagan uy vazifalari qolgan bo'lsa, eslatma kelib turadi.
    - Agar barcha vazifalar **Bajarildi (Done)** deb belgilansa, dastur umuman bezovta qilmaydi.

### 🗑️ Dasturni to'xtatish va o'chirish

Orqa fondagi avtomatik eslatmalarni butunlay o'chirish uchun **Command Prompt (cmd)** oynasiga quyidagilarni yozing:
```cmd
schtasks /Delete /TN "HomeworkReminder_Server" /F
schtasks /Delete /TN "HomeworkReminder_BootNotify" /F
schtasks /Delete /TN "HomeworkReminder_HourlyNotify" /F
```
