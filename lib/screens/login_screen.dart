// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:uasjirrr/screens/home_screen.dart';
import 'package:uasjirrr/screens/registration_screen.dart';
import 'package:uasjirrr/services/shared_preferences_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  bool _isLoading = false;

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      setState(() {
        _isLoading = true;
      });

      bool success = await SharedPreferencesHelper.login(_username, _password);

      setState(() {
        _isLoading = false;
      });

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid username or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          backgroundColor: Colors.black87,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: _isLoading
                ? CircularProgressIndicator()
                : Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Username'),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Enter username'
                                : null,
                            onSaved: (value) => _username = value!.trim(),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Enter password'
                                : null,
                            onSaved: (value) => _password = value!.trim(),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _login,
                            child: Text('Login'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF50C878),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegistrationScreen()),
                              );
                            },
                            child: Text('Don\'t have an account? Register'),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ));
  }
}
