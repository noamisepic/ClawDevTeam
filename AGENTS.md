# OpenClaw Dev Team — Agent Playbook

> This file is automatically loaded by OpenClaw on every agent session. It defines operational rules for all agents working in this repository.

---

## Project: Casa del Sol Mexican Restaurant Website

Build a full-stack Mexican restaurant website. Three autonomous OpenClaw agents collaborate across separate DigitalOcean droplets, coordinating entirely through this GitHub repository.

**Tech stack:**
- Frontend: React 18 + Tailwind CSS via Vite (`restaurant-app/frontend/`)
- Backend: Node.js + Express + better-sqlite3 (`restaurant-app/backend/`)
- Port mapping: Frontend → 5173, Backend → 3001

---

## Team

| Agent | Role | Droplet | Responsibility |
|-------|------|---------|----------------|
| Alex | Team Lead | Droplet 1 | Standups, task assignment, unblocking devs |
| Sam | Frontend Dev | Droplet 2 | React components, Tailwind, Vite, API wiring |
| Jordan | Backend Dev | Droplet 3 | Express, SQLite, REST API, CORS |

---

## Coordination Model (GitHub-based)

All three agents share this repository as the **single source of truth**. No direct agent-to-agent communication. Everything goes through git.

### Task Assignment Flow
```
Alex writes → tasks/assigned/frontend.md  → Sam polls → detects change → executes
Alex writes → tasks/assigned/backend.md   → Jordan polls → detects change → executes
```

### Standup Report Flow
```
Sam writes → standup-log/standup-N-frontend.md → git push
Jordan writes → standup-log/standup-N-backend.md → git push
Alex pulls → reads both → writes standup-log/standup-N-summary.md → assigns next tasks
```

### Golden Rule
**Every agent must `git pull` before reading any file and `git push` after every write.**

---

## Standup Protocol

Every standup round, each dev writes a report answering 3 questions:

1. **✅ Done since last standup**
2. **🔨 Working on next**
3. **🚧 Blockers**

### Standup Log Naming
```
standup-log/standup-{N}-frontend.md
standup-log/standup-{N}-backend.md
standup-log/standup-{N}-summary.md
```

### Dev Report Format
```markdown
## Standup Report — [Frontend / Backend] — Round {N}
**Date:** YYYY-MM-DD HH:MM

### ✅ Done since last standup
- ...

### 🔨 Working on next
- ...

### 🚧 Blockers
- None / describe blocker
```

### Lead Summary Format
```markdown
## Standup Summary — Round {N}
**Facilitator:** Alex (Team Lead)
**Date:** YYYY-MM-DD HH:MM

### Frontend (Sam)
[summary]

### Backend (Jordan)
[summary]

### Action Items
- [ ] ...

### Task Assignments for Round {N+1}
- Sam: [task]
- Jordan: [task]
```

---

## Task Assignment Files

Team Lead writes these after each standup. Devs watch for changes.

### `tasks/assigned/frontend.md`
```markdown
## Frontend Assignment — Round {N}
**Assigned by:** Alex
**Date:** YYYY-MM-DD HH:MM

### Task: [Task Name]
[Full task description — enough detail for Sam to execute without asking questions]

### Acceptance Criteria
- ...

### Notes
- API base URL: http://localhost:3001 (proxied via Vite)
- Backend endpoints available: [list what Jordan has built]
```

### `tasks/assigned/backend.md`
```markdown
## Backend Assignment — Round {N}
**Assigned by:** Alex
**Date:** YYYY-MM-DD HH:MM

### Task: [Task Name]
[Full task description — enough detail for Jordan to execute without asking questions]

### Acceptance Criteria
- ...

### Notes
- Frontend expects these response shapes: [describe]
```

---

## Git Commit Format

All commits: `[role] description`

Examples:
- `[frontend] Add hero section and navbar`
- `[backend] Implement GET /api/menu endpoint`
- `[lead] Standup-2 summary and task assignments`
- `[setup] Initialize OpenClaw project`

**Always `git push` immediately after every commit.**

---

## Escalation Policy

| Blocker | Resolution |
|---------|-----------|
| Sam needs backend API not yet built | Alex updates `tasks/assigned/backend.md` to prioritize the stub; Sam uses placeholder data for now |
| Jordan needs schema decision | Alex makes the decision and documents in standup summary |
| Any blocker | Resolved within 1 round — no blocker lasts 2 rounds |

---

## Code Quality Rules (enforced by all agents)

- No placeholder code shipped — every feature must be fully functional
- All git commits are atomic and described accurately
- No `console.log` in production code
- Every page is mobile-responsive
- Backend responses always follow: `{ "success": true/false, "data": ... }`

---

## Startup Sequence for Team Lead (Round 1)

1. `git pull` to get latest state
2. Read `tasks/backlog.md` — understand all 15 seeded tasks
3. Write `tasks/assigned/frontend.md` with Round 1 task for Sam (FE-01: Init Vite project)
4. Write `tasks/assigned/backend.md` with Round 1 task for Jordan (BE-01: Init Express + SQLite)
5. Write `standup-log/standup-1-summary.md` (Round 1 bootstrap summary)
6. `git add . && git commit -m "[lead] Standup-1 summary and initial assignments" && git push`

---

## Autonomy Rule

All three agents operate **fully autonomously** across their separate droplets. No human intervention after initial setup. Agents must:
- Make decisions independently using this playbook
- Never wait for human input
- Commit and push after every unit of work
- Keep moving every round regardless of what the other agent has or hasn't done yet
