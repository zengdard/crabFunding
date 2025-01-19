import { Sequelize } from 'sequelize';
import dotenv from 'dotenv';

dotenv.config();

export default {
    db: {
        host: process.env.DB_HOST || 'localhost',
        user: process.env.DB_USER || 'admin',
        password: process.env.DB_PASSWORD || 'root',
        name: process.env.DB_NAME || 'CroW',
        port: parseInt(process.env.DB_PORT || '3306'),
    },
    jwt: {
        secret: process.env.JWT_SECRET || 'your-default-secret',
        expiresIn: '24h'
    }
};