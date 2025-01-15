// lib/services/shared_preferences_helper.dart
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _keyUsername = 'username';
  static const String _keyPassword = 'password';
  static const String _keyIsLoggedIn = 'isLoggedIn';

  // Register a new user
  static Future<bool> register(String username, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Check if username already exists
      String? existingUsername = prefs.getString(_keyUsername);
      if (existingUsername != null && existingUsername == username) {
        return false; // Username already exists
      }

      await prefs.setString(_keyUsername, username);
      await prefs.setString(_keyPassword, password);
      // Do NOT set isLoggedIn to true here
      return true;
    } catch (e) {
      print('Error during registration: $e');
      return false;
    }
  }

  // Login user
  static Future<bool> login(String username, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      String? storedUsername = prefs.getString(_keyUsername);
      String? storedPassword = prefs.getString(_keyPassword);

      if (storedUsername == username && storedPassword == password) {
        await prefs.setBool(_keyIsLoggedIn, true);
        return true;
      }
      return false;
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_keyIsLoggedIn) ?? false;
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }

  // Logout user
  static Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyIsLoggedIn, false);
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}
