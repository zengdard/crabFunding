import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:crow_mobile/models/option_data.dart';

class OptionResultCard extends StatelessWidget {
  final OptionData data;
  final VoidCallback? onSave;

  const OptionResultCard({
    Key? key, 
    required this.data,
    this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface.withOpacity(0.8),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Symbole: ${data.symbol}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  IconButton.filledTonal(
                    icon: const Icon(Icons.bookmark_add_outlined),
                    onPressed: onSave,
                  ),
                ],
              ),
              const Divider(thickness: 2),
              _buildInfoRow(
                context,
                'Prix actuel:',
                NumberFormat.currency(symbol: '\$').format(data.currentPrice),
                Icons.attach_money,
              ),
              _buildInfoRow(
                context,
                'Volatilité:',
                '${(data.volatility * 100).toStringAsFixed(2)}%',
                Icons.show_chart,
              ),
              const SizedBox(height: 16),
              Text('Analyse des Options:', style: Theme.of(context).textTheme.titleMedium),
              Expanded(
                child: ListView.builder(
                  itemCount: data.optionContracts.length,
                  itemBuilder: (context, index) {
                    final OptionContract option = data.optionContracts[index];
                    return Card(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Strike: ${option.formattedStrike}'),
                            Text('Expiration: ${option.formattedExpiration}'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Last Price: ${option.lastPrice.toStringAsFixed(2)}'),
                                Text('Vol: ${option.volume}'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Bid: ${option.bid.toStringAsFixed(2)}'),
                                Text('Ask: ${option.ask.toStringAsFixed(2)}'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('IV: ${(option.impliedVolatility * 100).toStringAsFixed(1)}%'),
                                Text('OI: ${option.openInterest}'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Type: ${option.type}'),
                                _getRecommendationChip(option.recommendation[option.type] ?? ''),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
          ),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _getRecommendationChip(String recommendation) {
    Color color;
    switch (recommendation) {
      case 'overvalued':
        color = Colors.red;
        break;
      case 'undervalued':
        color = Colors.green;
        break;
      default:
        color = Colors.blue;
    }
    
    return Chip(
      label: Text(
        recommendation,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: color,
      padding: const EdgeInsets.all(4),
    );
  }
}
