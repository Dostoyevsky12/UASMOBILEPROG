// lib/main.dart
import 'package:flutter/material.dart';
import 'package:uasjirrr/screens/home_screen.dart';
import 'package:uasjirrr/screens/login_screen.dart';
import 'package:uasjirrr/services/shared_preferences_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isLoggedIn = await SharedPreferencesHelper.isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Notes App",
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(color: Colors.black87),
      ),
      home: isLoggedIn ? HomeScreen() : LoginScreen(),
    );
  }
}
