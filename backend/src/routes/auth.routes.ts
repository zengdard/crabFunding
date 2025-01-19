// src/routes/auth.routes.ts

import { Router } from 'express';
import { register, login } from '../controllers/auth.controller';
import { validate } from '../middleware/validation.middleware';
import { authenticate } from '../middleware/auth.middleware';

const router = Router();

// Schémas de validation
const registerSchema = {
    body: {
        email: { type: 'string', format: 'email' },
        password: { type: 'string', minLength: 6 }
    }
};

const loginSchema = {
    body: {
        email: { type: 'string', format: 'email' },
        password: { type: 'string' }
    }
};

// Routes d'authentification
router.post('/register', validate(registerSchema), register);
router.post('/login', validate(loginSchema), login);

// Route protégée pour tester l'authentification
router.get('/me', authenticate, (req, res) => {
    res.json({
        id: req.user?.id,
        email: req.user?.email,
        createdAt: req.user?.createdAt
    });
});

export default router;