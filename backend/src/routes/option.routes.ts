// src/routes/option.routes.ts

import { Router } from 'express';
import { analyzeOption } from '../controllers/option.controller';
import { authenticate } from '../middleware/auth.middleware';
import { validate } from '../middleware/validation.middleware';

const router = Router();

router.post('/analyze', 
    authenticate,
    validate({
        body: {
            symbol: { type: 'string', minLength: 1 },
            strikePrice: { type: 'number', minimum: 0 },
            expiry: { type: 'string', format: 'date-time' },
            volatility: { type: 'number', minimum: 0, maximum: 1 },
            optionType: { type: 'string', enum: ['call', 'put'] },
            marketPrice: { type: 'number', minimum: 0 }
        }
    }),
    analyzeOption
);

export default router;