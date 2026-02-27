const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const db = require('./db');

// Load environment variables
dotenv.config();

const app = express();
const PORT = process.env.PORT || 3001;

// Middleware
app.use(cors({
    origin: 'http://localhost:5173', // Frontend development server
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    allowedHeaders: ['Content-Type', 'Authorization']
}));

app.use(express.json());

// Request logging middleware
app.use((req, res, next) => {
    console.log(`${new Date().toISOString()} - ${req.method} ${req.path}`);
    next();
});

// Health check endpoint
app.get('/api/health', (req, res) => {
    try {
        // Test database connection
        const testQuery = db.prepare("SELECT 1").get();
        res.json({ 
            status: "ok",
            timestamp: new Date().toISOString(),
            database: "connected"
        });
    } catch (error) {
        console.error('Health check failed:', error);
        res.status(500).json({ 
            status: "error", 
            message: "Database connection failed",
            timestamp: new Date().toISOString()
        });
    }
});

// API routes will go here in future rounds
app.get('/api', (req, res) => {
    res.json({
        success: true,
        message: "Casa del Sol API - Ready for service!",
        endpoints: ["/api/health"]
    });
});

// 404 handler
app.use((req, res) => {
    res.status(404).json({
        success: false,
        message: "Endpoint not found"
    });
});

// Error handling middleware
app.use((error, req, res, next) => {
    console.error('Server error:', error);
    res.status(500).json({
        success: false,
        message: "Internal server error"
    });
});

// Start server
const server = app.listen(PORT, () => {
    console.log(`🌮 Casa del Sol Backend Server running on port ${PORT}`);
    console.log(`📡 Health check available at: http://localhost:${PORT}/api/health`);
    console.log(`🔗 CORS configured for: http://localhost:5173`);
});

// Graceful shutdown handling
process.on('SIGTERM', () => {
    console.log('SIGTERM signal received: closing HTTP server');
    server.close(() => {
        console.log('HTTP server closed');
        db.close();
        process.exit(0);
    });
});

process.on('SIGINT', () => {
    console.log('\nSIGINT signal received: closing HTTP server');
    server.close(() => {
        console.log('HTTP server closed');
        db.close();
        process.exit(0);
    });
});

module.exports = app;