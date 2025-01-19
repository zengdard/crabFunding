import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';
import '../services/api_service.dart';

class YahooFinanceService {
  static final _api = ApiService();

  static Future<Map<String, dynamic>> getOptionAnalysis(String symbol) async {
    try {
      final response = await _api.get('/api/options/analyze/$symbol');
      
      if (response.statusCode == 200) {
        return response.data;
      }
      throw Exception('Échec de l\'analyse des options');
    } catch (e) {
      throw Exception('Erreur réseau: $e');
    }
  }
}
