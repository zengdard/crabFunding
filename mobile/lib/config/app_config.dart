
class AppConfig {
  static String baseUrl = 'http://10.0.2.2:3000'; // Default to Android emulator localhost

  static void setBaseUrl(String url) {
    baseUrl = url;
  }
}