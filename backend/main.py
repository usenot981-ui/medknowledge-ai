from datetime import datetime, timezone
from pathlib import Path
import sqlite3
import feedparser
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

DB_PATH = Path(__file__).with_name("medknowledge.db")
app = FastAPI(title="MedKnowledge AI API", version="0.1.0")

# Development only. Restrict origins before production deployment.
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

def connect():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn

def initialise():
    with connect() as db:
        db.execute("""
        CREATE TABLE IF NOT EXISTS updates (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            source TEXT NOT NULL,
            url TEXT NOT NULL UNIQUE,
            published TEXT,
            summary TEXT,
            category TEXT DEFAULT 'Research',
            review_status TEXT DEFAULT 'under_review',
            created_at TEXT NOT NULL
        )
        """)

initialise()

class UpdateIn(BaseModel):
    title: str
    source: str
    url: str
    published: str | None = None
    summary: str | None = None
    category: str = "Research"

@app.get("/")
def root():
    return {"name": "MedKnowledge AI API", "status": "starter"}

@app.get("/health")
def health():
    return {"status": "ok", "time": datetime.now(timezone.utc).isoformat()}

@app.get("/updates")
def get_updates(limit: int = 50):
    limit = max(1, min(limit, 100))
    with connect() as db:
        rows = db.execute(
            "SELECT * FROM updates ORDER BY created_at DESC LIMIT ?", (limit,)
        ).fetchall()
    return [dict(row) for row in rows]

@app.post("/updates")
def add_update(item: UpdateIn):
    with connect() as db:
        db.execute("""
          INSERT OR IGNORE INTO updates
          (title, source, url, published, summary, category, review_status, created_at)
          VALUES (?, ?, ?, ?, ?, ?, 'under_review', ?)
        """, (item.title, item.source, item.url, item.published, item.summary,
              item.category, datetime.now(timezone.utc).isoformat()))
    return {"saved": True, "review_status": "under_review"}

@app.post("/admin/poll-rss")
def poll_rss():
    # Add only official feeds after verifying their terms and feed validity.
    feeds = []
    inserted = 0
    for feed_url in feeds:
        parsed = feedparser.parse(feed_url)
        source = parsed.feed.get("title", feed_url)
        for entry in parsed.entries[:30]:
            link, title = entry.get("link"), entry.get("title")
            if not link or not title:
                continue
            with connect() as db:
                before = db.total_changes
                db.execute("""
                  INSERT OR IGNORE INTO updates
                  (title, source, url, published, summary, category, review_status, created_at)
                  VALUES (?, ?, ?, ?, ?, 'Research', 'under_review', ?)
                """, (title, source, link, entry.get("published"),
                      entry.get("summary", ""), datetime.now(timezone.utc).isoformat()))
                inserted += db.total_changes - before
    return {"feeds_checked": len(feeds), "new_items": inserted,
            "note": "Collected items remain under review."}
