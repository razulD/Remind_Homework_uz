# Homework Reminder (Windows 10/11 uchun qo'llanma)

Uy vazifalarini nazorat qilish va har soatda Windows bildirishnomalari (Action Center) orqali eslatib turish uchun mo'ljallangan yengil va fonda ko'rinmas ishlovchi dastur.

---

## Boshlashdan oldin (Bir martalik tekshiruv)
Kompyuteringizda **Python 3** o'rnatilganligiga ishonch hosil qiling:
1. Agar Python o'rnatilmagan bo'lsa, uni [python.org](https://www.python.org/downloads/) saytidan yuklab oling.
2. **Muhim:** O'rnatish oynasining eng birinchi qadamida pastki qismdagi **"Add python.exe to PATH"** katakchasiga belgi qo'ying va shundan so'ng **Install Now** tugmasini bosing.

---

## O'rnatish tartibi (Bir marta bosish orqali)

1. Ushbu papkani kompyuteringizda doimiy turadigan joyga joylashtiring (masalan: `C:\Users\Ismingiz\Documents\HomeworkReminder`).
2. **`setup.bat`** fayli ustiga sichqoncha bilan ikki marta bosing.
3. Agar Windows xavfsizlik oynasi chiqib, ruxsat so'rasa (*"Do you want to allow this app to make changes to your device?"*), **Yes (Ha)** tugmasini bosing.
4. O'rnatish jarayoni tugashini 15–30 soniya kuting. Jarayon yakunlangach, brauzeringizda avtomatik ravishda **Homework Manager** boshqaruv paneli (`http://127.0.0.1:5000`) ochiladi.

---

## Dastur qanday ishlaydi?

* **Orqa fonda ko'rinmas ishlaydi:** Kompyuteringiz yoniq vaqtda dastur hech qanday qora `cmd` oynalarisiz, orqa fonda jim ishlaydi.
* **Boshqaruv paneliga kirish:** Vazifa qo'shish yoki bajarilganlarni belgilash uchun brauzeringizda **`http://127.0.0.1:5000`** manzilini xatcho'plarga (Bookmarks) saqlab qo'ying.
* **Aqlli eslatmalar:**
  * **Kompyuter yongandan 1 daqiqa o'tib**, dastur bajarilmagan uy vazifalari bor-yo'qligini tekshiradi va bildirishnoma chiqaradi.
  * **Har soat boshida** (1:00, 2:00, 3:00 va hokazo), agar bajarilmagan vazifalar bo'lsa, ekranning pastki o'ng burchagida eslatma paydo bo'ladi.
  * Bildirishnomadagi **"Open Dashboard"** tugmasini bosish orqali to'g'ridan-to'g'ri ro'yxatni ochish mumkin.
  * Agar barcha vazifalar **Bajarildi (Done)** deb belgilangan bo'lsa, dastur sizni bezovta qilmaydi.

---

## Papka joyini o'zgartirish bo'yicha eslatma
Agar dastur papkasini boshqa joyga ko'chirsangiz, yangi joyda **`setup.bat`** faylini yana bir marta ishga tushiring. Shunda Windows yangi manzilni eslab qoladi. `homework.json` ichidagi vazifalaringiz o'chib ketmaydi.

---

## Dasturni o'chirish (Uninstall)
Agar avtomatik eslatmalarni va orqa fondagi serverni butunlay to'xtatmoqchi bo'lsangiz, **Command Prompt (cmd)** oynasini ochib, quyidagi 3 ta buyruqni kiriting:

```cmd
schtasks /Delete /TN "HomeworkReminder_Server" /F
schtasks /Delete /TN "HomeworkReminder_BootNotify" /F
schtasks /Delete /TN "HomeworkReminder_HourlyNotify" /F
