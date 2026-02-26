# OpenClaw Dev Team — Reference Protocol

> **Note:** This file exists for reference. The authoritative operational playbook for OpenClaw agents is `AGENTS.md`. OpenClaw loads `AGENTS.md` automatically; this file supplements it with additional context.

## Project: Casa del Sol Mexican Restaurant Website

### Description
Build a full-stack Mexican restaurant website for "Casa del Sol". The site features a public-facing frontend with pages for Home, Menu, About, and Contact/Reservations, backed by a REST API serving menu data, reservation handling, and restaurant hours.

---

## Tech Stack
- **Frontend:** React 18 + Tailwind CSS via Vite
- **Backend:** Node.js + Express + better-sqlite3
- **Repo root:** `ClawDevTeam/`
- **Frontend dir:** `restaurant-app/frontend/`
- **Backend dir:** `restaurant-app/backend/`

---

## Team Roster

| Name   | Role         | Responsibilities                                              |
|--------|--------------|---------------------------------------------------------------|
| Alex   | Team Lead    | Run standups, assign tasks, synthesize reports, unblock devs  |
| Sam    | Frontend Dev | React components, Tailwind styling, Vite config, API wiring   |
| Jordan | Backend Dev  | Express server, SQLite DB, REST endpoints, CORS               |

---

## Standup Protocol

Every standup round, each dev answers 3 questions:

1. **✅ Done since last standup** — What did you complete?
2. **🔨 Working on next** — What will you do this round?
3. **🚧 Blockers** — What's blocking you? (or "None")

### Standup Log File Naming
```
standup-log/standup-{N}-frontend.md
standup-log/standup-{N}-backend.md
standup-log/standup-{N}-summary.md
```
Where `{N}` is the round number (1, 2, 3, ...).

### Standup Report Format (devs write this)
```markdown
## Standup Report — [Frontend Dev / Backend Dev] — Round {N}
**Date:** YYYY-MM-DD HH:MM

### ✅ Done since last standup
- ...

### 🔨 Working on next
- ...

### 🚧 Blockers
- None (or describe blocker)
```

### Standup Summary Format (Team Lead writes this)
```markdown
## Standup Summary — Round {N}
**Facilitator:** Alex (Team Lead)
**Date:** YYYY-MM-DD HH:MM

### Frontend (Sam)
[summary of Sam's report]

### Backend (Jordan)
[summary of Jordan's report]

### Action Items
- [ ] ...

### Task Assignments for Round {N+1}
- Sam: [task description]
- Jordan: [task description]
```

---

## Git Commit Format
All commits must follow this pattern:
```
[role] description
```
Examples:
- `[frontend] Add hero section to Home page`
- `[backend] Add GET /api/menu endpoint`
- `[lead] Update task assignments after round 2 standup`
- `[setup] Initialize ClawDevTeam project`

**After every commit, run `git push` to push to the remote.**

---

## Team Lead Startup Instructions (Round 1)

When invoked for the first time (Round 1):
1. Read `tasks/backlog.md` to understand all seeded tasks
2. Use TaskCreate to register each backlog item in the task system
3. Assign Round 1 tasks to Sam (Frontend) and Jordan (Backend)
4. Spawn Frontend Dev subagent → collect standup report
5. Spawn Backend Dev subagent → collect standup report
6. Write `standup-log/standup-1-summary.md`
7. Spawn each dev agent to execute their assigned Round 1 tasks
8. After task completion, commit and push

## Team Lead Ongoing Instructions (Round N > 1)

1. Read previous standup summary from `standup-log/standup-{N-1}-summary.md`
2. Check task board via TaskList
3. Spawn Frontend Dev for standup → reads `standup-log/standup-{N}-frontend.md`
4. Spawn Backend Dev for standup → reads `standup-log/standup-{N}-backend.md`
5. Write `standup-log/standup-{N}-summary.md`
6. If frontend is blocked on a backend API, create a stub JSON response
7. Assign next tasks, spawn devs to execute

---

## Escalation Policy
- If Frontend (Sam) is blocked waiting for a Backend API: Alex creates a stub (`/api/menu` returns hardcoded JSON) so Sam can proceed
- If Backend (Jordan) is blocked on schema decisions: Alex makes the call and documents it in the summary
- No blocker should last more than 1 round without resolution

---

## Task Board Usage
- Use `TaskCreate` to add new tasks (subject should be imperative, e.g., "Build Menu page")
- Use `TaskUpdate` to mark tasks in_progress or completed
- Use `TaskList` to see all current tasks and their statuses
- Tag tasks with owner in description: e.g., "Owner: Sam"

---

## Project Pages (Frontend)
1. **Home** — Hero banner, featured dishes, restaurant hours, CTA buttons
2. **Menu** — Category tabs (Appetizers, Mains, Desserts, Drinks), item cards with price/description
3. **About** — Restaurant story, team photos placeholder, values
4. **Contact/Reservations** — Reservation form (name, date, time, party size), map placeholder, phone/address

## API Endpoints (Backend)
- `GET /api/menu` — All menu items
- `GET /api/menu/:category` — Items filtered by category
- `POST /api/reservations` — Create a reservation
- `GET /api/hours` — Restaurant operating hours

---

## Autonomy Rule
This system operates **fully autonomously**. No human will intervene after initial setup. Agents must:
- Make decisions independently
- Unblock themselves using the escalation policy
- Commit and push code after every completed work unit
- Keep moving forward every round
