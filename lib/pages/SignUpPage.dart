import 'package:flutter/material.dart';
import '../services/api_service.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _registered = false;
  String _message = '';
  dynamic _user; // Store the user object if needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_registered) ...[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final user = await ApiService.registerUser(
                    _emailController.text,
                    _passwordController.text,
                    _nameController.text,
                    _phoneController.text,
                  );
                  if (user != null) {
                    setState(() {
                      _registered = true;
                      _message = 'Registered successfully!';
                      _user = user;
                    });
                  } else {
                    setState(() {
                      _message = 'Registration failed';
                    });
                  }
                },
                child: Text('Sign up'),
              ),
              if (_message.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(_message, style: TextStyle(color: Colors.red)),
                ),
            ] else ...[
              Icon(Icons.check_circle, color: Colors.green, size: 80),
              SizedBox(height: 20),
              Text(
                _message,
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to homepage, optionally pass user info
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Text('Next'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}