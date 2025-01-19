// src/services/blackscholes.service.ts

interface OptionAnalysis {
    strikePrice: number;
    expirationDate: string;
    callPrice: number;
    putPrice: number;
    impliedVolatility: number;
    recommendation: {
        call: 'overvalued' | 'undervalued' | 'fair';
        put: 'overvalued' | 'undervalued' | 'fair';
    };
}

interface StockData {
    currentPrice: number;
    volatility: number;
    optionChain?: any;
}

export class BlackScholesService {
    private static normalCDF(x: number): number {
        const t = 1 / (1 + 0.2316419 * Math.abs(x));
        const d = 0.3989423 * Math.exp(-x * x / 2);
        const p = d * t * (0.3193815 + t * (-0.3565638 + t * (1.781478 + t * (-1.821256 + t * 1.330274))));
        return x > 0 ? 1 - p : p;
    }

    static calculateOption(
        S: number,  // Prix actuel
        K: number,  // Prix d'exercice
        r: number,  // Taux sans risque
        t: number,  // Temps jusqu'à échéance
        sigma: number,  // Volatilité
        type: 'call' | 'put'
    ): number {
        const d1 = (Math.log(S / K) + (r + sigma * sigma / 2) * t) / (sigma * Math.sqrt(t));
        const d2 = d1 - sigma * Math.sqrt(t);

        if (type === 'call') {
            return S * this.normalCDF(d1) - K * Math.exp(-r * t) * this.normalCDF(d2);
        } else {
            return K * Math.exp(-r * t) * this.normalCDF(-d2) - S * this.normalCDF(-d1);
        }
    }

    static calculateAllOptions(stockData: StockData): OptionAnalysis[] {
        const results: OptionAnalysis[] = [];
        const riskFreeRate = 0.02; // Taux sans risque standard
        
        // Générer des prix d'exercice autour du prix actuel
        const currentPrice = stockData.currentPrice;
        const strikes = [
            currentPrice * 0.9,  // 10% sous le prix actuel
            currentPrice * 0.95, // 5% sous le prix actuel
            currentPrice,        // Au prix actuel
            currentPrice * 1.05, // 5% au-dessus du prix actuel
            currentPrice * 1.1   // 10% au-dessus du prix actuel
        ];

        // Générer des dates d'expiration
        const expiryDates = [
            30,  // 1 mois
            90,  // 3 mois
            180, // 6 mois
            365  // 1 an
        ];

        for (const days of expiryDates) {
            const timeToExpiry = days / 365; // Convertir en années
            const expirationDate = new Date();
            expirationDate.setDate(expirationDate.getDate() + days);

            for (const strike of strikes) {
                const callPrice = this.calculateOption(
                    currentPrice,
                    strike,
                    riskFreeRate,
                    timeToExpiry,
                    stockData.volatility,
                    'call'
                );

                const putPrice = this.calculateOption(
                    currentPrice,
                    strike,
                    riskFreeRate,
                    timeToExpiry,
                    stockData.volatility,
                    'put'
                );

                results.push({
                    strikePrice: strike,
                    expirationDate: expirationDate.toISOString(),
                    callPrice,
                    putPrice,
                    impliedVolatility: stockData.volatility,
                    recommendation: {
                        call: this.evaluateOption(0, callPrice), // Pas de prix de marché disponible
                        put: this.evaluateOption(0, putPrice)    // Pas de prix de marché disponible
                    }
                });
            }
        }

        return results;
    }

    private static evaluateOption(
        marketPrice: number,
        theoreticalPrice: number,
        threshold: number = 0.05
    ): 'overvalued' | 'undervalued' | 'fair' {
        if (!marketPrice) return 'fair';
        
        const difference = (marketPrice - theoreticalPrice) / theoreticalPrice;
        
        if (difference > threshold) return 'overvalued';
        if (difference < -threshold) return 'undervalued';
        return 'fair';
    }
}