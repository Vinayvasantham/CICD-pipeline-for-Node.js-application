const express = require('express');
const app = express();
const path = require('path');
const expressLayouts = require('express-ejs-layouts');

// Set view engine to EJS
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Use express-ejs-layouts middleware
app.use(expressLayouts);

// Set default layout
app.set('layout', 'layout');

// Routes
app.use('/', require('./routes/index'));

// Start server
const PORT = 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
