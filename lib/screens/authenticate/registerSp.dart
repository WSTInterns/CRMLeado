import 'package:brew_crew/screens/home/adminPath/adminHome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterSalesPersonScreen extends StatefulWidget {
  const RegisterSalesPersonScreen({super.key});

  @override
  _RegisterSalesPersonScreenState createState() =>
      _RegisterSalesPersonScreenState();
}

class _RegisterSalesPersonScreenState extends State<RegisterSalesPersonScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final userUid = FirebaseAuth.instance.currentUser?.uid.toString();
  final userMail = FirebaseAuth.instance.currentUser?.email.toString();

  final companyNameController = TextEditingController();
  final nameController = TextEditingController();
  final phoneNoController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _registerSalesPerson() async {
    final adminUser = FirebaseAuth.instance.currentUser;
    if (adminUser == null) {
      // The admin user is not logged in, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in as admin first.')),
      );
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = nameController.text.trim();
    final companyName = companyNameController.text.trim();
    final phoneNo = phoneNoController.text.trim();

    try {
      // Use a secondary app to create the sales person user
      final secondaryApp = await Firebase.initializeApp(
        name: 'salesPersonApp',
        options: Firebase.app().options,
      );
      final salesPersonUserCredential =
          await FirebaseAuth.instanceFor(app: secondaryApp)
              .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Delete the secondary app to ensure that the original admin user stays logged in

      // Create the sales person document in the users collection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(salesPersonUserCredential.user!.email)
          .set({
        'userUid': salesPersonUserCredential.user!.uid,
        'usermail': email,
        'adminID': adminUser.uid,
        'name': name,
        'companyName': companyName,
        'phoneNo': phoneNo,
        'isAdmin': '0',
      });

      await Firebase.app('salesPersonApp').delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sales person registered successfully.')),
      );
      _emailController.clear();
      _passwordController.clear();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to register sales person: ${e.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Sales Person'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: companyNameController,
                    decoration: const InputDecoration(labelText: 'Company Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter company name.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: phoneNoController,
                    decoration: const InputDecoration(labelText: 'Phone Number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number.';
                      }
                      else if (value.trim().length < 8) {
                        return 'Password must be 10 characters in length';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
              if (value != null) {
                if (value.contains('@') && value.endsWith('.com')) {
                  return null;
                }
                return 'Enter a Valid Email Address';
              }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'This field is required';
              }
              else if (value.trim().length < 8) {
                return 'Password must be at least 8 characters in length';
              }
              // Return null if the entered password is valid
              return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _registerSalesPerson();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => adminHome()));
                      }
                    },
                    child: const Text('Register'),
                  ),
            
                  // Text user_uid to see the current user is admin or not, comment it out later!!
                  // Text(" for admin $userMail")
                ],
              ),
            
          ),
        ),
      ),
    );
  }
}
