// src/services/yahoo.service.ts

import axios from 'axios';
import { Redis } from 'ioredis';
import { ApiError } from '../utils/ApiError';

const redis = new Redis({
    host: process.env.REDIS_HOST || 'localhost',
    port: Number(process.env.REDIS_PORT) || 6379,
});

const CACHE_DURATION = 300; // 5 minutes

interface StockData {
    currentPrice: number;
    volatility: number;
    optionChain?: any;
}

export class YahooFinanceService {
    static async getStockData(symbol: string): Promise<StockData> {
        // Vérifier le cache
        const cachedData = await redis.get(`stockData:${symbol}`);
        if (cachedData) {
            return JSON.parse(cachedData);
        }

        try {
            // Récupérer le prix actuel
            const priceResponse = await axios.get(
                `https://query1.finance.yahoo.com/v8/finance/chart/${symbol}?range=1d&interval=1m`
            );
            const currentPrice = priceResponse.data.chart.result[0].meta.regularMarketPrice;

            // Récupérer la volatilité historique (30 jours)
            const historicalData = await axios.get(
                `https://query1.finance.yahoo.com/v8/finance/chart/${symbol}?range=30d&interval=1d`
            );
            const prices = historicalData.data.chart.result[0].indicators.quote[0].close;
            const volatility = this.calculateVolatility(prices);

            // Récupérer la chaîne d'options si disponible
            const optionChain = await this.getOptionChain(symbol);

            const stockData: StockData = {
                currentPrice,
                volatility,
                optionChain
            };

            // Mettre en cache
            await redis.setex(`stockData:${symbol}`, CACHE_DURATION, JSON.stringify(stockData));

            return stockData;
        } catch (error) {
            throw new ApiError(500, `Failed to fetch data for ${symbol}`);
        }
    }

    private static calculateVolatility(prices: number[]): number {
        const returns = [];
        for (let i = 1; i < prices.length; i++) {
            returns.push(Math.log(prices[i] / prices[i - 1]));
        }
        
        const mean = returns.reduce((a, b) => a + b) / returns.length;
        const variance = returns.reduce((a, b) => a + Math.pow(b - mean, 2), 0) / returns.length;
        
        // Annualiser la volatilité
        return Math.sqrt(variance * 252);
    }

    private static async getOptionChain(symbol: string) {
        try {
            const response = await axios.get(
                `https://query1.finance.yahoo.com/v7/finance/options/${symbol}`
            );
            return response.data.optionChain.result[0];
        } catch (error) {
            return null;
        }
    }
}