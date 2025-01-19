import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crow_mobile/providers/auth_provider.dart';
import 'package:crow_mobile/providers/option_provider.dart';
import 'package:crow_mobile/screens/splash_screen.dart';
import 'package:crow_mobile/widgets/debug_overlay.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:crow_mobile/config/app_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configure base URL
  const baseUrl = String.fromEnvironment('API_URL', defaultValue: 'http://10.0.2.2:3000');
  AppConfig.setBaseUrl(baseUrl);
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => OptionProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CroW Options',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      locale: const Locale('fr'), // Optionnel : définir la locale
      supportedLocales: const [
        Locale('fr'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      home: const DebugOverlay(
        child: SplashScreen(),
      ),
    );
  }
}