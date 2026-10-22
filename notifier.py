import json
import os

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
FILE = os.path.join(BASE_DIR, "homework.json")
DASHBOARD_URL = "http://127.0.0.1:5000"


def get_active_tasks():
    if not os.path.exists(FILE):
        return []
    try:
        with open(FILE, "r", encoding="utf-8") as f:
            tasks = json.load(f)
        return [t for t in tasks if t.get("status", "active") == "active"]
    except (json.JSONDecodeError, OSError):
        return []


def format_notification_body(active_tasks):
    # Show up to 3 tasks directly in the notification popup
    lines = []
    for t in active_tasks[:3]:
        lines.append(f"• [{t.get('subject', 'TASK')}] {t.get('task', '')}")
    if len(active_tasks) > 3:
        remaining = len(active_tasks) - 3
        lines.append(f"...and {remaining} more pending.")
    return "\n".join(lines)


def send_windows_notification(title, message):
    # Primary: winotify (Native Windows 10/11 Action Center Toast with click action)
    try:
        from winotify import Notification, audio

        toast = Notification(
            app_id="Homework Reminder",
            title=title,
            msg=message,
            duration="short",
            launch=DASHBOARD_URL,
        )
        toast.set_audio(audio.Default, loop=False)
        toast.add_actions(label="Open Dashboard", launch=DASHBOARD_URL)
        toast.show()
        return
    except Exception:
        pass

    # Fallback: plyer system tray notification
    try:
        from plyer import notification

        notification.notify(
            title=title,
            message=message,
            app_name="Homework Reminder",
            timeout=10,
        )
    except Exception:
        pass


if __name__ == "__main__":
    active = get_active_tasks()
    if active:
        count = len(active)
        word = "Task" if count == 1 else "Tasks"
        header = f"You have {count} Pending Homework {word}"
        body = format_notification_body(active)
        send_windows_notification(header, body)
