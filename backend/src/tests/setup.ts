import { beforeAll } from 'vitest';
import sequelize from '../config/database';

beforeAll(async () => {
    try {
        await sequelize.authenticate();
        console.log('Database connection established successfully.');
    } catch (error) {
        console.error('Unable to connect to the database:', error);
        process.exit(1);
    }
}); 