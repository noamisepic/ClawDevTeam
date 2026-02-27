# Frontend Assignment — Round 1
**Assigned by:** Alex (Team Lead)  
**Date:** 2026-02-27 04:20 UTC

## Task: FE-01 - Initialize Vite + React + Tailwind project
**Priority:** High (blocker for all other frontend tasks)

### Description
Set up the complete frontend foundation in `restaurant-app/frontend/`. This is the foundation that everything else will build on, so it needs to be rock-solid.

### Implementation Steps
1. **Initialize Vite project**:
   ```bash
   cd restaurant-app/frontend
   npm create vite@latest . -- --template react
   npm install
   ```

2. **Install required dependencies**:
   ```bash
   npm install react-router-dom
   npm install -D tailwindcss postcss autoprefixer
   npx tailwindcss init -p
   ```

3. **Configure Tailwind CSS**:
   - Update `tailwind.config.js` with proper content paths
   - Replace `src/index.css` with Tailwind directives
   - Import Tailwind in main entry file

4. **Configure Vite proxy**:
   - Update `vite.config.js` to proxy `/api/*` requests to `http://localhost:3001`
   - This will allow frontend to call backend APIs without CORS issues

5. **Set up React Router**:
   - Create basic routing structure in `src/App.jsx`
   - Create placeholder pages: Home, Menu, About, Contact

6. **Configure custom color palette**:
   - Add Casa del Sol brand colors to Tailwind config
   - Warm oranges, deep reds, earth tones for Mexican restaurant theme

### Acceptance Criteria
- [ ] `npm run dev` starts successfully on port 5173
- [ ] `npm run build` completes without errors
- [ ] Basic routing works (/, /menu, /about, /contact)
- [ ] Tailwind CSS classes work correctly
- [ ] API proxy is configured (test with a simple fetch to `/api/health`)
- [ ] No console errors in browser
- [ ] Hot reload works properly

### Notes
- Backend will be on port 3001 (Jordan is setting it up simultaneously)
- Use semantic HTML structure from the start
- Keep file structure clean and consistent
- After this task, you'll build the shared layout (navbar/footer) in Round 2

### Commit Format
`[frontend] Initialize Vite + React + Tailwind project with API proxy`