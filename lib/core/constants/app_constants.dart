class AppConstants {
  static const String appName = 'Clean Architecture App';
  static const String baseUrl = 'https://fakestoreapi.com';
  static const String jsonPlaceholderUrl = 'https://jsonplaceholder.typicode.com';

  // Hive box names
  static const String notesBox = 'notes_box';
  static const String appSettingsBox = 'app_settings_box';

  // Validation patterns
  static final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d).{6,}$');
}
