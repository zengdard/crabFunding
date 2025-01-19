import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crow_mobile/models/option_data.dart';
import 'package:crow_mobile/providers/option_provider.dart';
import 'package:crow_mobile/widgets/option_result_card.dart';

class OptionAnalysisScreen extends StatefulWidget {
  const OptionAnalysisScreen({Key? key}) : super(key: key);

  @override
  _OptionAnalysisScreenState createState() => _OptionAnalysisScreenState();
}

class _OptionAnalysisScreenState extends State<OptionAnalysisScreen> {
  final _symbolController = TextEditingController();

  void _saveAnalysis() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Analyse sauvegardée')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analyse d\'Options')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _symbolController,
              decoration: const InputDecoration(
                labelText: 'Symbole du Stock',
                suffixIcon: Icon(Icons.search),
              ),
              textCapitalization: TextCapitalization.characters,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _analyzeOption,
              child: const Text('Analyser'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<OptionProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (provider.optionData == null) {
                    return const Center(child: Text('Entrez un symbole pour analyser'));
                  }
                  return OptionResultCard(
                    data: provider.optionData!,
                    onSave: _saveAnalysis,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _analyzeOption() async {
    if (_symbolController.text.isNotEmpty) {
      await context.read<OptionProvider>().analyzeOption(_symbolController.text);
    }
  }
}