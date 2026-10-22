import json
import sys
import os
from flask import Flask, render_template, request, redirect, url_for

# Redirect stdout/stderr when running invisibly under pythonw.exe
# Prevents Werkzeug/Flask logging from crashing when no console is attached
if sys.stdout is None:
    sys.stdout = open(os.devnull, "w")
if sys.stderr is None:
    sys.stderr = open(os.devnull, "w")

# Resolve absolute paths so Windows Task Scheduler never writes to System32
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
FILE = os.path.join(BASE_DIR, "homework.json")
TEMPLATE_DIR = os.path.join(BASE_DIR, "templates")

SUBJECTS = [
    "ITS",
    "ENTERPRISE IN IT",
    "WEBSITE DEVELOPMENT",
    "STUDY SKILLS",
    "PROGRAMMING",
    "HISTORY",
    "OTHERS",
]


def load_tasks():
    if os.path.exists(FILE):
        try:
            with open(FILE, "r", encoding="utf-8") as f:
                return json.load(f)
        except json.JSONDecodeError:
            return []
    return []


def save_tasks(tasks):
    with open(FILE, "w", encoding="utf-8") as f:
        json.dump(tasks, f, indent=4)


app = Flask(__name__, template_folder=TEMPLATE_DIR)


@app.route("/")
def index():
    tasks = load_tasks()
    active_tasks = [
        (i, t) for i, t in enumerate(tasks) if t.get("status", "active") == "active"
    ]
    return render_template("index.html", subjects=SUBJECTS, tasks=active_tasks)


@app.route("/add", methods=["POST"])
def add():
    subj = request.form.get("subject")
    if subj == "OTHERS":
        subj = request.form.get("custom_subject", "").strip()
    task_text = request.form.get("task", "").strip()
    if subj and task_text:
        tasks = load_tasks()
        tasks.append({"subject": subj, "task": task_text, "status": "active"})
        save_tasks(tasks)
    return redirect(url_for("index"))


@app.route("/done/<int:task_id>")
def mark_done(task_id):
    tasks = load_tasks()
    if 0 <= task_id < len(tasks):
        tasks[task_id]["status"] = "done"
        save_tasks(tasks)
    return redirect(url_for("index"))


@app.route("/archive")
def archive():
    tasks = load_tasks()
    done_tasks = [t for t in tasks if t.get("status") == "done"]
    return render_template("archive.html", tasks=done_tasks)


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=5000, debug=False)
