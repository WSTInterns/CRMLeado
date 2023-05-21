import 'package:brew_crew/screens/home/homescreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/models/firebaseuser.dart';
import 'authenticate/handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'authenticate/regAdminInfo.dart';
import 'home/adminPath/adminHome.dart';
import 'home/start_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);
    if (user == null) {
      return Handler();
    } else {
      return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold
            (body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return RegisterScreen();
          }
          final data = snapshot.data!.data() as Map<String, dynamic>?;
          String isAdmin = data != null && data.containsKey('isAdmin') ? data['isAdmin'] : '0';
          if (isAdmin == '1') {
            return adminHome();
          } else {
            return StartScreen();
          }
        },
      );
    }
  }
}
