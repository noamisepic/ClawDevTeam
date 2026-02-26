# Casa del Sol — Task Backlog

> This backlog is seeded for Round 1. Alex (Team Lead) reads this and registers tasks via TaskCreate at the start of Round 1.

---

## Frontend Tasks (Sam)

### FE-01: Initialize Vite + React + Tailwind project
**Priority:** High (blocker for all other frontend tasks)
**Description:**
Set up the Vite project in `restaurant-app/frontend/`. Install React 18, Tailwind CSS, PostCSS, Autoprefixer, and React Router. Configure `vite.config.js` with a proxy for `/api/*` → `http://localhost:3001`. Verify `npm run dev` starts without errors.

### FE-02: Create shared layout (Navbar + Footer)
**Priority:** High
**Description:**
Build `src/components/Navbar.jsx` and `src/components/Footer.jsx`. Navbar includes: logo ("Casa del Sol"), nav links (Home, Menu, About, Contact), and a "Reserve a Table" CTA button. Footer includes: address, phone, hours summary, and social icon placeholders. Use the warm orange/stone color palette.

### FE-03: Build Home page
**Priority:** High
**Description:**
Build `src/pages/Home.jsx` with:
- Hero section: full-width banner with background image placeholder, tagline "Authentic Mexican Cuisine", CTA buttons ("View Menu", "Make Reservation")
- Featured dishes section: 3 dish cards (pull from `/api/menu` or use placeholder data)
- Hours section: display restaurant hours (pull from `/api/hours` or use placeholder)
- "Our Story" teaser with link to About page

### FE-04: Build Menu page
**Priority:** High
**Description:**
Build `src/pages/Menu.jsx` with:
- Category tabs: Appetizers, Mains, Desserts, Drinks
- Item cards: name, description, price, image placeholder
- Data from `GET /api/menu` or placeholder array
- Smooth tab switching animation

### FE-05: Build About page
**Priority:** Medium
**Description:**
Build `src/pages/About.jsx` with:
- Restaurant story section ("Founded in 1998...")
- Values section (Fresh ingredients, Family recipes, Community)
- Team section with placeholder photos
- A "Traditions" section about the cuisine

### FE-06: Build Contact/Reservation page
**Priority:** High
**Description:**
Build `src/pages/Contact.jsx` with:
- Reservation form: name, email, date, time, party size (1–12), special requests
- Form submits to `POST /api/reservations`
- Success confirmation message with confirmation code
- Contact info: address, phone, email
- Map placeholder (static image or iframe placeholder)

### FE-07: Add mobile-responsive styles
**Priority:** Medium
**Description:**
Audit all pages for mobile responsiveness. Ensure:
- Navbar collapses to hamburger menu on mobile
- Cards stack vertically on small screens
- Text sizes scale appropriately
- Touch targets are at least 44px
- No horizontal scroll on any page

### FE-08: Wire API calls to live backend
**Priority:** Medium (depends on backend being ready)
**Description:**
Replace all placeholder data with live API calls:
- Home page: fetch featured dishes from `/api/menu`
- Home page: fetch hours from `/api/hours`
- Menu page: fetch items from `/api/menu` and `/api/menu/:category`
- Contact page: POST to `/api/reservations`
Add loading spinners and error states for all fetches.

---

## Backend Tasks (Jordan)

### BE-01: Initialize Express server + SQLite database
**Priority:** High (blocker for all other backend tasks)
**Description:**
Set up Express in `restaurant-app/backend/src/index.js`. Install express, better-sqlite3, cors, dotenv. Create `src/db.js` to initialize SQLite connection and run schema migrations. Port: 3001. Include health check endpoint: `GET /api/health → { status: "ok" }`.

### BE-02: Seed menu data
**Priority:** High
**Description:**
Create `src/seed.js` with the full Casa del Sol menu data. Run seed on first startup (check if DB is empty). Categories: appetizers, mains, desserts, drinks. See backend-dev.md for full item list with prices.

### BE-03: Implement GET /api/menu
**Priority:** High
**Description:**
Create `src/routes/menu.js`. Implement `GET /api/menu` returning all menu items in `{ success: true, data: [...] }` format. Include item: id, name, category, description, price, is_available.

### BE-04: Implement GET /api/menu/:category
**Priority:** High
**Description:**
Add route for `GET /api/menu/:category`. Validate that category is one of: appetizers, mains, desserts, drinks. Return 404 with error message if invalid category. Return filtered items.

### BE-05: Implement POST /api/reservations
**Priority:** High
**Description:**
Create `src/routes/reservations.js`. Implement `POST /api/reservations`. Validate required fields: name, email, date, time, partySize. Generate a confirmation code (e.g., `CDS-XXXXXX`). Store in DB. Return `{ success: true, data: { id, confirmationCode } }`.

### BE-06: Implement GET /api/hours
**Priority:** Medium
**Description:**
Create `src/routes/hours.js`. Return static restaurant hours:
- Monday: Closed
- Tuesday–Thursday: 11:00 AM – 10:00 PM
- Friday–Saturday: 11:00 AM – 11:00 PM
- Sunday: 10:00 AM – 9:00 PM

### BE-07: Add CORS, error handling, and graceful shutdown
**Priority:** Medium
**Description:**
- Configure CORS for `http://localhost:5173` and `http://localhost:4173` (Vite dev + preview)
- Add global error handler middleware
- Add 404 handler for unknown routes
- Handle SIGTERM/SIGINT for graceful shutdown (close DB connection)
- Add request logging middleware

---

## Suggested Round Assignments

### Round 1
- **Sam:** FE-01 (Init Vite project)
- **Jordan:** BE-01 (Init Express + SQLite)

### Round 2
- **Sam:** FE-02 (Navbar + Footer) + FE-03 (Home page)
- **Jordan:** BE-02 (Seed data) + BE-03 (GET /api/menu)

### Round 3
- **Sam:** FE-04 (Menu page)
- **Jordan:** BE-04 (GET /api/menu/:category) + BE-05 (POST /api/reservations)

### Round 4
- **Sam:** FE-05 (About) + FE-06 (Contact/Reservation)
- **Jordan:** BE-06 (GET /api/hours) + BE-07 (CORS + error handling)

### Round 5
- **Sam:** FE-07 (Mobile responsive) + FE-08 (Wire API calls)
- **Jordan:** Polish, additional validation, test all endpoints
