import { Request, Response } from 'express';
import { YahooFinanceService } from '../services/yahoo.service';
import { BlackScholesService } from '../services/blackscholes.service';
import { ApiError } from '../utils/ApiError';

const handleError = (error: unknown): { status: number; message: string } => {
    if (error instanceof ApiError) {
        return { status: error.statusCode, message: error.message };
    }
    if (error instanceof Error) {
        return { status: 500, message: error.message };
    }
    return { status: 500, message: 'An unexpected error occurred' };
};

export class OptionsController {
    static async analyzeOption(req: Request, res: Response) {
        try {
            const { symbol } = req.params;
            
            // Récupérer les données du stock via Yahoo Finance
            const stockData = await YahooFinanceService.getStockData(symbol);
            
            // Calculer les analyses d'options avec Black-Scholes
            const optionAnalysis = BlackScholesService.calculateAllOptions(stockData);

            res.json({
                symbol,
                currentPrice: stockData.currentPrice,
                volatility: stockData.volatility,
                optionAnalysis,
                optionChain: stockData.optionChain
            });
        } catch (error: unknown) {
            const { status, message } = handleError(error);
            res.status(status).json({ 
                error: 'Failed to analyze options',
                details: message 
            });
        }
    }
}
