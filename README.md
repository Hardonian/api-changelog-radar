# API Changelog Radar

**Status: Scaffold / Proof-of-Concept** — not a working product.

This repository contains an early-stage scaffold for a planned changelog monitoring service. It sets up the skeleton (Cloudflare Worker, D1 schema, static HTML pages) but none of the core functionality has been implemented yet.

## What's Here

| Layer | What exists | Status |
|---|---|---|
| **Worker** (`deploy/workers/src/worker.js`) | Three routes: `GET /health`, `GET /api/v1/plans` (hardcoded JSON), and a 404 catch-all. CORS preflight handled. | ✅ Routes exist |
| **D1 Schema** (`deploy/d1/schema.sql`) | Well-designed tables for `sources`, `snapshots`, `diffs`, `alerts`, and `plans` with seed data. | ✅ Schema defined |
| **Frontend** (`deploy/frontend/index.html`) | Static page with a "Create Source" form that POSTs to `/api/v1/sources` — an endpoint that **does not exist**. | 🚫 Non-functional |
| **Landing** (`deploy/landing/index.html`) | Static landing page with a lead capture form that POSTs to `/api/v1/leads` — an endpoint that **does not exist**. | 🚫 Non-functional |
| **Deploy CI** (`.github/workflows/deploy.yml`) | GitHub Actions workflow that deploys worker and Pages to Cloudflare. | ✅ Pipeline wired |
| **Pricing** | Hardcoded plans JSON in worker.js and seed data in schema.sql. **No billing/subscription code exists.** | 🚫 Placeholder only |

## Tech Stack

- **Runtime:** Cloudflare Workers (JavaScript)
- **Database:** Cloudflare D1 (SQLite-compatible)
- **Deploy:** Wrangler via GitHub Actions
- **Frontends:** Static HTML/CSS/JS (Cloudflare Pages)

## What's *Not* Implemented

Despite the product-like wrapper, none of the following features exist in any code:

- ❌ **HTTP fetching** — Worker has no outbound fetch logic. It cannot retrieve any remote changelog, doc page, or webhook spec.
- ❌ **Diff algorithm** — No text comparison, no snapshot diffing, no change detection.
- ❌ **Snapshot storage** — Workers do not write to D1. The `DB` binding is declared in `wrangler.toml` but never used.
- ❌ **Alert dispatch** — No email, Slack, webhook, or any notification channel.
- ❌ **Scheduled/cron jobs** — No recurring checks or polling.
- ❌ **User accounts / auth** — No authentication, no teams, no multi-tenancy.
- ❌ **Billing / subscriptions** — Hardcoded plans JSON only; no Stripe, no metering, no payment flow.

## What Would Need to Be Built

To turn this scaffold into a functional service:

1. **Source CRUD** — Implement `POST /api/v1/sources`, `GET /api/v1/sources`, etc., backed by D1.
2. **Polling engine** — A scheduled (cron-triggered) Worker that fetches URLs from `sources` table on a cadence.
3. **Content fetching** — HTTP fetch logic that retrieves HTML/JSON from monitored URLs, handles rate limiting, caching, and errors.
4. **Diff engine** — Compare new snapshots against the previous one; compute added/removed lines and changed sections. Store results in the `diffs` table.
5. **Alert dispatch** — Send notifications (email, Slack, webhook) based on `alerts` configuration when a diff is detected.
6. **Billing integration** — Wire plans to a payment provider, enforce limits per plan.
7. **Frontend functionality** — Wire the static HTML pages to real API endpoints.
8. **Lead capture** — Implement `POST /api/v1/leads` or remove the landing page form.

## Project Structure

```
deploy/
├── workers/
│   ├── src/worker.js       # Cloudflare Worker entry point
│   ├── wrangler.toml       # Worker config + D1 binding
│   └── package.json
├── frontend/index.html     # Dashboard UI (scaffold)
├── landing/index.html      # Marketing landing (scaffold)
└── d1/schema.sql           # D1 database schema
.github/workflows/deploy.yml
```
