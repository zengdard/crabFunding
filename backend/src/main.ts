// src/main.ts

import express from 'express';
import cors from 'cors';
import authRoutes from './routes/auth.routes';
import optionRoutes from './routes/option.routes';
import { errorHandler } from './middleware/error.middleware';
import sequelize from './config/database';

const app = express();

// Middleware globaux
app.use(cors());
app.use(express.json());

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/options', optionRoutes);

// Route de test/santé
app.get('/health', (req, res) => {
    res.json({ status: 'ok', timestamp: new Date() });
});

// Gestion des erreurs
app.use(errorHandler);

// Gestion des routes non trouvées
app.use((req, res) => {
    res.status(404).json({ message: 'Route not found' });
});

// Fonction de démarrage
async function start() {
    try {
        await sequelize.authenticate();
        console.log('Database connection established successfully.');
        
        const port = process.env.PORT || 3000;
        app.listen(port, () => {
            console.log(`Server is running on port ${port}`);
        });
    } catch (error) {
        console.error('Unable to start server:', error);
        process.exit(1);
    }
}

// Démarrage du serveur si ce n'est pas un test
if (process.env.NODE_ENV !== 'test') {
    start();
}

// Export pour les tests
export default app;

// Gestion des erreurs non capturées
process.on('unhandledRejection', (error) => {
    console.error('Unhandled Rejection:', error);
});

process.on('uncaughtException', (error) => {
    console.error('Uncaught Exception:', error);
    process.exit(1);
});