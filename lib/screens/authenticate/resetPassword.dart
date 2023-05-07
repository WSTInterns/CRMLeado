import 'package:brew_crew/screens/authenticate/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              autofocus: false,
              onChanged: (value) {
                setState(() {});
              },
              validator: (value) {
                if (value != null) {
                  if (value.contains('@') && value.endsWith('.com')) {
                    return null;
                  }
                  return 'Enter a Valid Email Address';
                }
              },
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0))),
            ),
            SizedBox(
              height: 48,
            ),
            ElevatedButton(
                onPressed: () {
                  try {
                    auth.sendPasswordResetEmail(email: emailController.text)
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Password reset email sent.')));
                          Navigator.push(context,MaterialPageRoute(builder: (context) => Login()),);
                    });
                  } on Exception catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Failed to reset password. $e')));
                    print(e);
                  }
                },
                child: Text("Reset"))
          ],
        ),
      ),
    );
  }
}
