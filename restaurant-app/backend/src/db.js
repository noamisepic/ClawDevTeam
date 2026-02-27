const Database = require('better-sqlite3');
const path = require('path');
const fs = require('fs');

// Ensure data directory exists
const dataDir = path.join(__dirname, '..', 'data');
if (!fs.existsSync(dataDir)) {
    fs.mkdirSync(dataDir, { recursive: true });
}

// Database connection
const dbPath = path.join(dataDir, 'casa_del_sol.db');
const db = new Database(dbPath);

// Configure database
db.pragma('journal_mode = WAL'); // Better performance for concurrent access
db.pragma('foreign_keys = ON');  // Enable foreign key constraints

console.log(`📊 Database connected: ${dbPath}`);

// Create tables function
function createTables() {
    try {
        // Menu items table
        db.exec(`
            CREATE TABLE IF NOT EXISTS menu_items (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                category TEXT NOT NULL CHECK (category IN ('appetizers', 'mains', 'desserts', 'drinks')),
                description TEXT,
                price DECIMAL(10,2) NOT NULL,
                is_available BOOLEAN DEFAULT 1,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP
            )
        `);

        // Reservations table
        db.exec(`
            CREATE TABLE IF NOT EXISTS reservations (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                email TEXT NOT NULL,
                date TEXT NOT NULL,
                time TEXT NOT NULL,
                party_size INTEGER NOT NULL CHECK (party_size > 0 AND party_size <= 20),
                special_requests TEXT,
                confirmation_code TEXT UNIQUE NOT NULL,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP
            )
        `);

        // Restaurant hours table
        db.exec(`
            CREATE TABLE IF NOT EXISTS restaurant_hours (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                day_of_week TEXT NOT NULL CHECK (day_of_week IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')),
                open_time TEXT,
                close_time TEXT,
                is_closed BOOLEAN DEFAULT 0
            )
        `);

        console.log('✅ Database tables created successfully');

        // Initialize restaurant hours if empty
        const hoursCount = db.prepare("SELECT COUNT(*) as count FROM restaurant_hours").get();
        if (hoursCount.count === 0) {
            console.log('🕒 Initializing restaurant hours...');
            initializeRestaurantHours();
        }

    } catch (error) {
        console.error('❌ Error creating database tables:', error);
        throw error;
    }
}

// Initialize restaurant hours with default schedule
function initializeRestaurantHours() {
    const insertHours = db.prepare(`
        INSERT INTO restaurant_hours (day_of_week, open_time, close_time, is_closed)
        VALUES (?, ?, ?, ?)
    `);

    const defaultHours = [
        { day: 'Monday', open: '11:00', close: '22:00', closed: false },
        { day: 'Tuesday', open: '11:00', close: '22:00', closed: false },
        { day: 'Wednesday', open: '11:00', close: '22:00', closed: false },
        { day: 'Thursday', open: '11:00', close: '22:00', closed: false },
        { day: 'Friday', open: '11:00', close: '23:00', closed: false },
        { day: 'Saturday', open: '10:00', close: '23:00', closed: false },
        { day: 'Sunday', open: '10:00', close: '21:00', closed: false }
    ];

    const insertMany = db.transaction((hours) => {
        for (const hour of hours) {
            insertHours.run(hour.day, hour.open, hour.close, hour.closed ? 1 : 0);
        }
    });

    insertMany(defaultHours);
    console.log('✅ Restaurant hours initialized');
}

// Database health check function
function healthCheck() {
    try {
        const result = db.prepare("SELECT 1 as test").get();
        return result.test === 1;
    } catch (error) {
        console.error('Database health check failed:', error);
        return false;
    }
}

// Get database statistics
function getStats() {
    try {
        const menuCount = db.prepare("SELECT COUNT(*) as count FROM menu_items").get();
        const reservationCount = db.prepare("SELECT COUNT(*) as count FROM reservations").get();
        const hoursCount = db.prepare("SELECT COUNT(*) as count FROM restaurant_hours").get();

        return {
            menuItems: menuCount.count,
            reservations: reservationCount.count,
            restaurantHours: hoursCount.count
        };
    } catch (error) {
        console.error('Error getting database stats:', error);
        return { error: error.message };
    }
}

// Initialize database
createTables();

// Export database instance and utility functions
module.exports = db;
module.exports.healthCheck = healthCheck;
module.exports.getStats = getStats;
module.exports.close = () => {
    console.log('🔒 Closing database connection...');
    db.close();
};