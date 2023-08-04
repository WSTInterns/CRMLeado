import 'dart:ffi';

import 'package:brew_crew/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/screens/authenticate/registerSp.dart';
import '../../authenticate/handler.dart';
import 'package:firebase_auth/firebase_auth.dart';

class adminHome extends StatefulWidget {
  const adminHome({super.key});

  @override
  State<StatefulWidget> createState() {
    return _adminHome();
  }
}

class _adminHome extends State<adminHome> {
  final AuthService _auth = AuthService();
  User? user = FirebaseAuth.instance.currentUser;

  signOut() async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => Handler()),
  (Route<dynamic> route) => false, // Remove all routes in the stack
);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff4B56D2),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RegisterSalesPersonScreen()));
        },
        icon: const Icon(Icons.add),
        label: const Text('Add SalesPerson'),
      ),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Admin HomePage'),
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                signOut();
              },
              icon: const Icon(Icons.logout_outlined),
              label: const Text('Logout'))
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('isAdmin', isEqualTo: "0")
            .where( 'adminID', isEqualTo:user?.uid )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final users = snapshot.data!.docs;
          // print(users);   //for debug
          if (users.isEmpty) {
            return const Center(
              child: Text('No users found.'),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: users.length,
            padding: const EdgeInsets.all(5.0),
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user['name'] ?? ''),
                subtitle: Text(user['phoneNo'] ?? ''),
                trailing: Text(user['usermail'] ?? ''),
              );
            },
          );
        },
      ),
    );
  }
}
