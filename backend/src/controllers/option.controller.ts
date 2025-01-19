// src/controllers/option.controller.ts

import { Request, Response, NextFunction } from 'express';
import { YahooFinanceService } from '../services/yahoo.service';
import { BlackScholesService } from '../services/blackscholes.service';
import { ApiError } from '../utils/ApiError';

const handleError = (error: unknown): ApiError => {
    if (error instanceof ApiError) {
        return error;
    }
    if (error instanceof Error) {
        return new ApiError(500, error.message);
    }
    return new ApiError(500, 'An unexpected error occurred');
};

export const analyzeOption = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const { symbol } = req.body;

        if (!symbol) {
            throw new ApiError(400, 'Symbol is required');
        }

        // Récupérer les données du stock
        const stockData = await YahooFinanceService.getStockData(symbol);
        
        // Calculer les options
        const analysisResults = BlackScholesService.calculateAllOptions(stockData);

        res.json({
            symbol,
            currentPrice: stockData.currentPrice,
            volatility: stockData.volatility,
            options: analysisResults
        });

    } catch (error: unknown) {
        next(handleError(error));
    }
};