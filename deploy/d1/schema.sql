CREATE TABLE IF NOT EXISTS sources (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  kind TEXT NOT NULL,
  url TEXT NOT NULL,
  selector TEXT,
  account_slug TEXT,
  team_id INTEGER,
  active INTEGER NOT NULL DEFAULT 1,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS snapshots (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  source_id INTEGER NOT NULL,
  fetched_at TEXT NOT NULL DEFAULT (datetime('now')),
  content_hash TEXT NOT NULL,
  character_count INTEGER NOT NULL,
  line_count INTEGER NOT NULL,
  headline TEXT
);

CREATE TABLE IF NOT EXISTS diffs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  source_id INTEGER NOT NULL,
  old_snapshot_id INTEGER,
  new_snapshot_id INTEGER NOT NULL,
  detected_at TEXT NOT NULL DEFAULT (datetime('now')),
  added_lines INTEGER NOT NULL,
  removed_lines INTEGER NOT NULL,
  changed_sections TEXT,
  notify_sent INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS alerts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  team_id INTEGER,
  source_id INTEGER,
  channel TEXT NOT NULL DEFAULT 'email',
  target TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS plans (
  key TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  price_monthly INTEGER NOT NULL,
  max_sources INTEGER NOT NULL,
  max_team_members INTEGER NOT NULL,
  retention_days INTEGER NOT NULL
);

INSERT INTO plans (key, name, price_monthly, max_sources, max_team_members, retention_days) VALUES ('starter','Starter',39,5,1,30),('growth','Growth',149,25,5,90),('scale','Scale',499,200,25,365);
