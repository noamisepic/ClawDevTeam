# Backend Assignment — Round 1
**Assigned by:** Alex (Team Lead)  
**Date:** 2026-02-27 04:20 UTC

## Task: BE-01 - Initialize Express server + SQLite database
**Priority:** High (blocker for all other backend tasks)

### Description
Set up the complete backend foundation in `restaurant-app/backend/`. This includes the Express server, SQLite database connection, and basic project structure that everything else will build on.

### Implementation Steps
1. **Initialize Node.js project**:
   ```bash
   cd restaurant-app/backend
   npm init -y
   ```

2. **Install core dependencies**:
   ```bash
   npm install express better-sqlite3 cors dotenv
   npm install -D nodemon
   ```

3. **Create project structure**:
   ```
   src/
   ├── index.js          # Main server entry point
   ├── db.js             # Database connection and schema
   ├── routes/           # API route handlers (empty for now)
   └── middleware/       # Custom middleware (empty for now)
   ```

4. **Set up Express server** (`src/index.js`):
   - Initialize Express app on port 3001
   - Add CORS middleware for `http://localhost:5173`
   - Add JSON parsing middleware
   - Include health check endpoint: `GET /api/health → { status: "ok" }`
   - Add graceful shutdown handling

5. **Set up SQLite database** (`src/db.js`):
   - Create database connection using better-sqlite3
   - Create initial schema for: menu_items, reservations, restaurant_hours
   - Export database instance for use in routes
   - Add basic error handling for DB operations

6. **Configure npm scripts**:
   - `npm run dev` → nodemon for development
   - `npm start` → node for production

### Database Schema (Initial)
```sql
-- Menu items table
CREATE TABLE menu_items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    category TEXT NOT NULL, -- appetizers, mains, desserts, drinks
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    is_available BOOLEAN DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Reservations table  
CREATE TABLE reservations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    date TEXT NOT NULL,
    time TEXT NOT NULL,
    party_size INTEGER NOT NULL,
    special_requests TEXT,
    confirmation_code TEXT UNIQUE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Restaurant hours (static for now)
CREATE TABLE restaurant_hours (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    day_of_week TEXT NOT NULL,
    open_time TEXT,
    close_time TEXT,
    is_closed BOOLEAN DEFAULT 0
);
```

### Acceptance Criteria
- [ ] `npm run dev` starts server successfully on port 3001
- [ ] `GET http://localhost:3001/api/health` returns `{"status": "ok"}`
- [ ] SQLite database file is created successfully
- [ ] All database tables are created with correct schema
- [ ] CORS headers allow requests from frontend (port 5173)
- [ ] Server logs requests and handles graceful shutdown
- [ ] No errors or warnings in server startup
- [ ] Clean project structure follows Node.js best practices

### Notes
- Frontend will be on port 5173 (Sam is setting it up simultaneously)
- All API responses should follow format: `{ "success": true/false, "data": ... }`
- Use environment variables for configuration (DB path, port, etc.)
- Keep error handling consistent across all endpoints
- After this task, you'll seed the menu data in Round 2

### Commit Format
`[backend] Initialize Express server with SQLite database and health endpoint`