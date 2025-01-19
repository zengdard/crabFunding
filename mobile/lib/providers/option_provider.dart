import 'package:flutter/material.dart';
import '../services/yahoo_finance_service.dart';
import '../models/option_data.dart';

class OptionProvider with ChangeNotifier {
  bool _isLoading = false;
  OptionData? _optionData;
  String? _error;

  bool get isLoading => _isLoading;
  OptionData? get optionData => _optionData;
  String? get error => _error;

  Future<void> analyzeOption(String symbol) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Ajout des données de test
      if (symbol.toUpperCase() == 'AAPL' || symbol.toUpperCase() == 'TSLA') {
        _optionData = _getMockOptionData(symbol.toUpperCase());
      } else {
        // Garder l'appel API existant comme fallback
        final result = await YahooFinanceService.getOptionAnalysis(symbol.toUpperCase());
        _optionData = OptionData.fromJson(result);
      }
      _error = null;
    } catch (e) {
      _error = 'Erreur lors de l\'analyse: ${e.toString()}';
      _optionData = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  OptionData _getMockOptionData(String symbol) {
    final now = DateTime.now();
    final mockData = {
      'AAPL': OptionData(
        symbol: 'AAPL',
        currentPrice: 175.50,
        volatility: 0.25,
        optionContracts: [
          OptionContract(
            type: 'CALL',
            strikePrice: 180.0,
            expirationDate: now.add(const Duration(days: 30)),
            bid: 3.15,
            ask: 3.25,
            lastPrice: 3.20,
            volume: 1500,
            openInterest: 5000,
            impliedVolatility: 0.28,
            recommendation: {
              'signal': 'ACHAT',
              'reason': 'Forte tendance haussière',
            },
          ),
          OptionContract(
            type: 'PUT',
            strikePrice: 170.0,
            expirationDate: now.add(const Duration(days: 30)),
            bid: 2.45,
            ask: 2.55,
            lastPrice: 2.50,
            volume: 1200,
            openInterest: 4500,
            impliedVolatility: 0.26,
            recommendation: {
              'signal': 'VENTE',
              'reason': 'Support solide',
            },
          ),
        ],
      ),
      'TSLA': OptionData(
        symbol: 'TSLA',
        currentPrice: 242.75,
        volatility: 0.45,
        optionContracts: [
          OptionContract(
            type: 'CALL',
            strikePrice: 250.0,
            expirationDate: now.add(const Duration(days: 45)),
            bid: 8.25,
            ask: 8.45,
            lastPrice: 8.35,
            volume: 2500,
            openInterest: 7500,
            impliedVolatility: 0.48,
            recommendation: {
              'signal': 'NEUTRE',
              'reason': 'Volatilité élevée',
            },
          ),
          OptionContract(
            type: 'PUT',
            strikePrice: 235.0,
            expirationDate: now.add(const Duration(days: 45)),
            bid: 6.75,
            ask: 6.95,
            lastPrice: 6.85,
            volume: 2000,
            openInterest: 6500,
            impliedVolatility: 0.46,
            recommendation: {
              'signal': 'ACHAT',
              'reason': 'Protection baissière intéressante',
            },
          ),
        ],
      ),
    };

    return mockData[symbol]!;
  }
}
