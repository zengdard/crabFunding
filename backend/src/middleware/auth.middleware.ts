// src/middleware/auth.middleware.ts

import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import { ApiError } from '../utils/ApiError';
import config from '../config/config';
import User from '../models/user.model';

interface JwtPayload {
    id: string;
}

declare global {
    namespace Express {
        interface Request {
            user?: User;
        }
    }
}

export const authenticate = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const authHeader = req.headers.authorization;

        if (!authHeader) {
            throw new ApiError(401, 'No token provided');
        }

        const token = authHeader.split(' ')[1];
        if (!token) {
            throw new ApiError(401, 'Invalid token format');
        }

        try {
            const decoded = jwt.verify(token, config.jwt.secret) as JwtPayload;
            const user = await User.findByPk(decoded.id);

            if (!user) {
                throw new ApiError(401, 'User not found');
            }

            req.user = user;
            next();
        } catch (err) {
            throw new ApiError(401, 'Invalid token');
        }
    } catch (error) {
        next(error);
    }
};