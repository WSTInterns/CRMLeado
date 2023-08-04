import 'dart:ffi';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() {
    return RegisterScreenState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String companyName = '';
  String phoneNo = '';
  String? userUid = FirebaseAuth.instance.currentUser?.uid;
  String? userMailId = FirebaseAuth.instance.currentUser?.email;
  String isAdmin = '1';
  getName(name) {
    this.name = name;
  }

  getCompanyName(companyName) {
    this.companyName = companyName;
  }

  getPhoneNo(phoneNo) {
    this.phoneNo = phoneNo;
  }

  create() async {
    DocumentReference doc =
        await FirebaseFirestore.instance.collection("users").doc(userUid);

    Map<String, dynamic> users = {
      "userUid": userUid,
      "name": name,
      "companyName": companyName,
      "phoneNo": phoneNo,
      "usermail": userMailId,
      "isAdmin": isAdmin,
    };

    doc.set(users).whenComplete(() => {print("created")});
  }

  // update() async {
  //   DocumentReference doc =
  //       await FirebaseFirestore.instance.collection("hopes").doc(username);

  //   Map<String, dynamic> salesPerson = {"firstname": firstname,"lastname": lastname,"username": username,"password": password, };

  //   doc.set(salesPerson).whenComplete(() => {print("updated")});
  // }

  // read() async {
  //   DocumentReference doc =
  //       await FirebaseFirestore.instance.collection("hopes").doc(name);

  //   doc.get().then<dynamic>((DocumentSnapshot datasnapshot) {
  //     if (datasnapshot.exists) {
  //       print("Name : " + datasnapshot.get("name").toString());
  //       print("Company Name : " + datasnapshot.get("companyName").toString());
  //     } else {
  //       print("No data found");
  //     }
  //   });
  // }

  // delete() async {
  //   DocumentReference doc =
  //       await FirebaseFirestore.instance.collection("user").doc(username);
  //   doc.delete().then((value) {
  //     print("$username deleted");
  //   });
  // }

//Do not change the code above, work on front end styling below this line.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.person),
                hintText: 'Enter Name',
                labelText: 'Name',
              ),
              onChanged: (String value) {
                getName(value);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.person),
                hintText: 'Enter companyName',
                labelText: 'companyname',
              ),
              onChanged: (String value) {
                getCompanyName(value);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.calendar_today),
                hintText: 'Enter phoneNo',
                labelText: 'Phone No',
              ),
              onChanged: (String value) {
                getPhoneNo(value);
              },
            ),
            ElevatedButton(
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                create();
                print("$name user created");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Wrapper()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
