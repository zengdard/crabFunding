import 'dart:io' show Platform;

class ApiConfig {
  static bool get isDevelopment => 
      const bool.fromEnvironment('DEBUG', defaultValue: true);

  static String get baseUrl {
    if (isDevelopment) {
      // Utiliser l'IP du conteneur Docker pour le développement
      return Platform.isAndroid 
          ? 'http://10.0.2.2:3000'  // Pour l'émulateur Android
          : 'http://localhost:3000'; // Pour iOS et web
    }
    return 'https://api.production.com';
  }
}
