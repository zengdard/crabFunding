import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:crow_mobile/config/api_config.dart';

class DebugOverlay extends StatelessWidget {
  final Widget child;

  const DebugOverlay({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      textDirection: TextDirection.ltr, // Ajout explicite de la direction
      children: [
        child,
        if (ApiConfig.isDevelopment)
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.red.withOpacity(0.5),
              child: const Text(
                'DEBUG MODE',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
