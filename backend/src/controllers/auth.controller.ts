import { Request, Response, NextFunction } from 'express';
import bcrypt from 'bcryptjs';  // Changé de 'bcrypt' à 'bcryptjs'
import jwt from 'jsonwebtoken';
import User from '../models/user.model';
import { ApiError } from '../utils/ApiError';
import config from '../config/config';

export const register = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const { email, password } = req.body;

        const existingUser = await User.findOne({ where: { email } });
        if (existingUser) {
            throw new ApiError(400, 'Email already exists');
        }

        const hashedPassword = await bcrypt.hash(password, 10);
        
        const user = await User.create({
            email: email,
            password: hashedPassword,
        });

        const token = jwt.sign({ id: user.id }, config.jwt.secret, {
            expiresIn: '24h',
        });

        res.status(201).json({
            message: 'User created successfully',
            token,
            userId: user.id
        });
    } catch (error) {
        next(error);
    }
};

export const login = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const { email, password } = req.body;

        const user = await User.findOne({ where: { email } });
        if (!user) {
            throw new ApiError(401, 'Invalid credentials');
        }

        const isPasswordValid = await bcrypt.compare(password, user.password);
        if (!isPasswordValid) {
            throw new ApiError(401, 'Invalid credentials');
        }

        const token = jwt.sign({ id: user.id }, config.jwt.secret, {
            expiresIn: '24h',
        });

        res.json({
            message: 'Login successful',
            token,
            userId: user.id
        });
    } catch (error) {
        next(error);
    }
};