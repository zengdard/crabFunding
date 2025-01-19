import { Request, Response, NextFunction } from 'express';
import { ApiError } from '../utils/ApiError';

interface ValidationSchema {
    body?: Record<string, any>;
    params?: Record<string, any>;
    query?: Record<string, any>;
}

export const validate = (schema: ValidationSchema) => {
    return (req: Request, res: Response, next: NextFunction) => {
        try {
            if (schema.body) {
                const { email, password } = req.body;
                if (schema.body.email && !email) {
                    throw new ApiError(400, 'Email is required');
                }
                if (schema.body.password && !password) {
                    throw new ApiError(400, 'Password is required');
                }
                if (schema.body.email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                    throw new ApiError(400, 'Invalid email format');
                }
                if (schema.body.password?.minLength && password.length < schema.body.password.minLength) {
                    throw new ApiError(400, `Password must be at least ${schema.body.password.minLength} characters long`);
                }
            }
            next();
        } catch (error) {
            next(error);
        }
    };
};