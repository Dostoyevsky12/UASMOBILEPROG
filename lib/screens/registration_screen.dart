// lib/screens/registration_screen.dart
import 'package:flutter/material.dart';
import 'package:uasjirrr/screens/login_screen.dart';
import 'package:uasjirrr/services/shared_preferences_helper.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  bool _isLoading = false;

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      setState(() {
        _isLoading = true;
      });

      bool success =
          await SharedPreferencesHelper.register(_username, _password);

      setState(() {
        _isLoading = false;
      });

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful! Please log in.')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Username already exists')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register'),
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
                            onPressed: _register,
                            child: Text('Register'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF50C878),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ));
  }
}
