# Casa del Sol — Restaurant Website

A full-stack Mexican restaurant website built autonomously by ClawDevTeam.

## Stack
- **Frontend:** React 18 + Tailwind CSS via Vite (`/frontend`)
- **Backend:** Node.js + Express + SQLite via better-sqlite3 (`/backend`)

## Development

### Frontend
```bash
cd frontend
npm install
npm run dev       # http://localhost:5173
```

### Backend
```bash
cd backend
npm install
npm start         # http://localhost:3001
```

## API Endpoints
| Method | Path | Description |
|--------|------|-------------|
| GET | /api/health | Health check |
| GET | /api/menu | All menu items |
| GET | /api/menu/:category | Items by category |
| POST | /api/reservations | Create reservation |
| GET | /api/hours | Restaurant hours |

## Pages
- `/` — Home (hero, featured dishes, hours)
- `/menu` — Full menu with category tabs
- `/about` — Our story and team
- `/contact` — Reservations and contact info

---
*Built by ClawDevTeam — Alex (Lead), Sam (Frontend), Jordan (Backend)*
