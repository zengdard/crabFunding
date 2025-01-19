import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import request from 'supertest';
import app from '../main';
import sequelize from '../config/database';

describe('Option Routes', () => {
    let authToken: string;

    beforeAll(async () => {
        // Créer un utilisateur et obtenir le token
        const loginRes = await request(app)
            .post('/api/auth/login')
            .send({
                email: 'test@example.com',
                password: 'password123'
            });
        authToken = loginRes.body.token;
    });

    afterAll(async () => {
        await sequelize.close();
    });

    describe('POST /api/options/analyze', () => {
        it('should analyze stock options', async () => {
            const res = await request(app)
                .post('/api/options/analyze')
                .set('Authorization', `Bearer ${authToken}`)
                .send({
                    symbol: 'AAPL'
                });

            expect(res.status).toBe(200);
            expect(res.body).toHaveProperty('symbol');
            expect(res.body).toHaveProperty('currentPrice');
            expect(res.body).toHaveProperty('options');
        });

        it('should return 400 for invalid symbol', async () => {
            const res = await request(app)
                .post('/api/options/analyze')
                .set('Authorization', `Bearer ${authToken}`)
                .send({
                    symbol: ''
                });

            expect(res.status).toBe(400);
        });
    });
});