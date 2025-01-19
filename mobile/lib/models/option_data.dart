import 'package:intl/intl.dart';

class OptionContract {
  final String type;
  final double strikePrice;
  final DateTime expirationDate;
  final double bid;
  final double ask;
  final double lastPrice;
  final int volume;
  final int openInterest;
  final double impliedVolatility;
  final Map<String, String> recommendation;

  const OptionContract({
    required this.type,
    required this.strikePrice,
    required this.expirationDate,
    required this.bid,
    required this.ask,
    required this.lastPrice,
    required this.volume,
    required this.openInterest,
    required this.impliedVolatility,
    required this.recommendation,
  });

  factory OptionContract.fromJson(Map<String, dynamic> json) {
    return OptionContract(
      type: json['type'],
      strikePrice: json['strikePrice'].toDouble(),
      expirationDate: DateTime.parse(json['expirationDate']),
      bid: json['bid'].toDouble(),
      ask: json['ask'].toDouble(),
      lastPrice: json['lastPrice'].toDouble(),
      volume: json['volume'],
      openInterest: json['openInterest'],
      impliedVolatility: json['impliedVolatility'].toDouble(),
      recommendation: Map<String, String>.from(json['recommendation']),
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'strikePrice': strikePrice,
    'expirationDate': expirationDate.toIso8601String(),
    'bid': bid,
    'ask': ask,
    'lastPrice': lastPrice,
    'volume': volume,
    'openInterest': openInterest,
    'impliedVolatility': impliedVolatility,
    'recommendation': recommendation,
  };

  String get formattedStrike => 
      NumberFormat.currency(symbol: '\$').format(strikePrice);
  
  String get formattedExpiration => 
      DateFormat('dd/MM/yyyy').format(expirationDate);

  int get daysUntilExpiration =>
      expirationDate.difference(DateTime.now()).inDays;

  bool get isExpired => DateTime.now().isAfter(expirationDate);
}

class OptionData {
  final String symbol;
  final double currentPrice;
  final double volatility;
  final List<OptionContract> optionContracts;
  final DateTime timestamp;

  OptionData({
    required this.symbol,
    required this.currentPrice,
    required this.volatility,
    required this.optionContracts,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory OptionData.fromJson(Map<String, dynamic> json) {
    return OptionData(
      symbol: json['symbol'],
      currentPrice: json['currentPrice'].toDouble(),
      volatility: json['volatility'].toDouble(),
      optionContracts: (json['optionContracts'] as List)
          .map((contract) => OptionContract.fromJson(contract))
          .toList(),
      timestamp: json['timestamp'] != null 
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'symbol': symbol,
    'currentPrice': currentPrice,
    'volatility': volatility,
    'optionContracts': optionContracts.map((e) => e.toJson()).toList(),
    'timestamp': timestamp.toIso8601String(),
  };

  String get formattedPrice => 
      NumberFormat.currency(symbol: '\$').format(currentPrice);
  
  String get formattedVolatility => 
      '${(volatility * 100).toStringAsFixed(2)}%';

  List<OptionContract> get activeOptions => 
      optionContracts.where((option) => !option.isExpired).toList();

  List<OptionContract> get expiredOptions => 
      optionContracts.where((option) => option.isExpired).toList();

  OptionContract? findNearestStrike([double? targetPrice]) {
    final target = targetPrice ?? currentPrice;
    return optionContracts.reduce((a, b) {
      return (a.strikePrice - target).abs() < (b.strikePrice - target).abs()
          ? a
          : b;
    });
  }

  List<OptionContract> getOptionsExpiringIn(int days) {
    final targetDate = DateTime.now().add(Duration(days: days));
    return optionContracts.where((option) {
      return option.expirationDate.isBefore(targetDate) && !option.isExpired;
    }).toList();
  }
}
