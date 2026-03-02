enum AppEnvironment { dev, prod }

class AppConfig {
  final AppEnvironment environment;
  final String apiBaseUrl;
  final String firebaseApiKey;

  AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.firebaseApiKey,
  });

  static AppConfig dev() => AppConfig(
    environment: AppEnvironment.dev,
    apiBaseUrl: 'https://dev.api.example.com',
    firebaseApiKey: 'DEV_API_KEY',
  );

  static AppConfig prod() => AppConfig(
    environment: AppEnvironment.prod,
    apiBaseUrl: 'https://api.example.com',
    firebaseApiKey: 'PROD_API_KEY',
  );
}
