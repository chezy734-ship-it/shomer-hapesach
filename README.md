# שומר הפתח — Shomer HaPetach

![banner](docs/banner.svg)

**גרסה 0.0.10** | Windows 10/11 (64-bit) | Python 3.10+ | PyQt6

כלי בקרה וניהול זמן שימוש במחשב: מסך נעילה עם תאריך עברי, חסימת מקשים (Windows/Alt+Tab/Ctrl+Alt+Del...), ניטור תוכנות, מדפסות עם חיוב אוטומטי, שוברים, והגדרות ניהול מלאות.

---

## 📥 הורדה והתקנה

| קובץ | קישור |
|---|---|
| `Shomer-HaPetach.exe` | [הורדה ישירה](https://github.com/chezy734-ship-it/shomer-hapesach/raw/main/dist/Shomer-HaPetach.exe) |

> ⚠️ **הרצה כמנהל (Administrator)** — נדרשת לחסימות רג'סטרי (קליק ימני → "הפעל כמנהל").

### מהקוד

```bash
pip install PyQt6 pywin32 psutil
python main.py
```

### מחשב ללא אינטרנט
```cmd
:: במחשב עם אינטרנט:
pip download PyQt6 pywin32 psutil --dest C:\shomer_packages
:: במחשב ללא אינטרנט:
pip install --no-index --find-links=C:\shomer_packages PyQt6 pywin32 psutil
python main.py
```

---

## 👥 ברירות מחדל

| משתמש | סיסמה | הרשאות |
|---|---|---|
| מנהל מערכת | `admin` | מנהל מלא |

**כניסה להגדרות:** F8 בכל מקום במסך הנעילה ← הקש סיסמת מנהל. או "כניסה להגדרות" במסך הכניסה.

---

## 🔒 מה נחסם במסך הנעילה

- מקש Windows + כל צירוף Win+X
- Alt+Tab, Alt+F4, Alt+Esc (מניעת מעבר חלונות)
- Ctrl+Esc (תפריט התחל), Ctrl+Shift+Esc (Task Manager)
- **Ctrl+Alt+Del** — דרך הרג'סטרי (דורש הרצה כמנהל)
- Print Screen, Sleep, F1–F12

### מגבלות טכניות ידועות

| מגבלה | הסבר |
|---|---|
| Ctrl+Alt+Del לא נחסם 100% | החסימה דרך רג'סטרי עובדת ב-Windows 10/11 Home אך לא תמיד ב-Enterprise/Education עם Group Policy |
| Taskbar יכול להופיע רגעית | החלון חוזר לקדמה תוך פחות משנייה |
| תוכנות עם הרשאות System | תוכנות גבוהות מ-Administrator לא תסגרנה |

---

## 🖨️ ניטור מדפסות וחיוב

1. לשונית **מדפסות** → סמנו "מנוטר" למדפסות הרצויות → "הגדר תעריפים"
2. תעריף לכל סוג: A4 שחור, A4 צבע, A3 שחור, A3 צבע
3. לשונית **תשלום** → הגדרת חבילת הדפסות או "מחיר דקת שימוש"

**אלגוריתם:** יש חבילת הדפסות → נוכו עמודים מהחבילה; אין → חישוב שווי כספי וניכוי דקות שימוש. Toast notification אחרי כל הדפסה.

> דורש: `pip install pywin32`

---

## 🎟️ שוברים

- לשונית **תשלום** → בחרו חבילה → "הנפק שובר" (עד 500 בבת אחת)
- כל שובר מסומן ✓/⬜ לפי מימוש, ייצוא ל-CSV עם סטטוס עדכני

---

## 🔨 קימפול ל-EXE

```bash
pip install pyinstaller

pyinstaller --onefile --windowed --uac-admin ^
  --add-data "BlockACD.reg;." --add-data "UnblockACD.reg;." ^
  --name="shomer-hapetach" main.py
```

הקובץ המוכן: `dist\shomer-hapetach.exe` — הריצו תמיד כמנהל לתפקוד מלא.

---

## 🗂️ מבנה קבצים

```
shomer_hapetach/
├── main.py                ← נקודת כניסה
├── config_manager.py      ← ניהול הגדרות
├── lock_screen.py         ← מסך נעילה
├── welcome_screen.py      ← מסך כניסה
├── exit_screen.py         ← מסך יציאה
├── admin_panel.py         ← פאנל הגדרות (12 לשוניות)
├── time_manager.py        ← ספירת זמן
├── session_widget.py      ← חלונית זמן צפה
├── keyboard_hook.py       ← חסימת מקשים
├── app_monitor.py         ← ניטור תוכנות
├── registry_manager.py    ← רג'סטרי Windows
├── print_monitor.py       ← ניטור הדפסות + חיוב
├── BlockACD.reg / UnblockACD.reg  ← חסימת/שחרור Ctrl+Alt+Del
├── install.bat            ← התקנה מהירה
└── requirements.txt
```

---

## ❓ פתרון בעיות

| בעיה | פתרון |
|---|---|
| "Access Denied" | קליק ימני על main.py → "הפעל כמנהל" |
| פאנל הגדרות לא נפתח | F8 ← הקש `admin` ← Enter |
| לא מוצג בלוק Ctrl+Alt+Del | הרצה כמנהל → הגדרות → "החל כעת" |

---

## 📋 היסטוריית גרסאות אחרונה

- **0.0.10:** תיקון הדפסות לא מוצגות (Toast כ-instance variable, זיהוי JOB_STATUS_PRINTED, מניעת חיוב כפול) · תאריך עברי מדויק במסך הנעילה (חישוב מובנה + hdate) · הגדרות שעה/תאריך בלשונית מסך נעילה · שיפור חסימת מקש Windows
- **0.0.9:** תיקון קריטי — יציאת משתמש לא גורמת ל-Windows logoff (whitelist) · ניקוי לשונית אודות · גרסה 0.0.9
- **0.0.8:** כפתור יציאה מכבה לגמרי · ניטור הדפסות משופר · snapshot ראשוני מונע חיוב כפול
