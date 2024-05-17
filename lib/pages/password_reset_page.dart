import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PasswordResetPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  Future<void> requestPasswordReset(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.31:8000/password-reset/'),
      body: {
        'email': emailController.text,
      },
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Reset Email Sent'),
            content: Text('Check your email to reset your password.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to send reset email. Please try again later.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Enter your email',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => requestPasswordReset(context),
              child: Text('Send Password Reset Email'),
            ),
          ],
        ),
      ),
    );
  }
}
