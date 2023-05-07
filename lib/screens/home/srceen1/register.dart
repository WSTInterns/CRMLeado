import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:brew_crew/screens/home/phone.dart';
import 'package:brew_crew/screens/home/homescreen.dart';
import 'package:intl/intl.dart';

class StoreContact extends StatefulWidget {
  const StoreContact(this.title, this.number, {super.key});

  final String title;
  final String number;

  @override
  State<StoreContact> createState() => _StoreContactState();
}

class _StoreContactState extends State<StoreContact> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  String? email, notes;
  final _formkey = GlobalKey<FormState>();
  createlead() async {
    DateTime dateTime = DateTime.now();
    String formattedDate = DateFormat('d MMMM h:mm a').format(dateTime);
    DocumentReference doc =
        await FirebaseFirestore.instance.collection("Leads").doc(email);
    Map<String, dynamic> leadlist = {
      "name": widget.title,
      "email": email,
      "phoneNo": int.parse(widget.number),
      "notes": notes,
      "activity_status": 'warm',
      "createdAt": formattedDate,
      "uid":FirebaseAuth.instance.currentUser!.uid,
    };
    doc.set(leadlist).whenComplete(() => {print("created")});
    print(leadlist);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomeBar(
              title: "",
            )));
  }

  @override
  void initState() {
    super.initState();
    print(widget.title);
    print(widget.number);
    nameController.text = widget.title;
    numberController.text = widget.number;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text('Add New Client',
                style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.black,
                tooltip: 'Show Snackbar',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomeBar(
                            title: "",
                          )));
                })),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 15.5,
          ),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, bottom: 0, right: 15, top: 0),
                  child: Text(
                    "CLIENT NAME",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: TextFormField(
                    validator: (value) {
                      // Check if value is valid phone number with 10 digits
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                    enabled: false,
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff000000),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.5, color: Color(0xffD9ACF5)),
                      ),
                      // hintText: 'Enter a search term',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 23,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, bottom: 0, right: 15, top: 0),
                  child: Text(
                    "PHONE NUMBER",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: TextFormField(
                    validator: (value) {
                      // Check if value is valid phone number with 10 digits
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      } else if (value.length != 10) {
                        return 'Phone number must be 10 digits';
                      }
                      return null;
                    },
                    enabled: false,
                    controller: numberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.black),
                      // ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.5, color: Color(0xffD9ACF5)),
                      ),
                      // errorBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(
                      //       width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                      // ),
                      // border: OutlineInputBorder(),
                      // hintText: 'Enter the Phone Number',

                      // hintText: 'Ent',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 23,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, bottom: 0, right: 15, top: 0),
                  child: Text(
                    "EMAIL ADDRESS",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: TextFormField(
                    validator: (value) {
                      // Check if value is valid phone number with 10 digits
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      this.email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.black),
                      // ),

                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.5, color: Color(0xffD9ACF5)),
                      ),
                      // errorBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(
                      //       width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                      // ),
                      // border: OutlineInputBorder(),
                      hintText: 'eg. abc@mail.com',
                      hintStyle: TextStyle(
                        fontFamily: "Montserrat",
                      ),

                      // hintText: 'Ent',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 23,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 17, bottom: 0, right: 15, top: 0),
                  child: Text(
                    "NOTES",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: TextFormField(
                    onChanged: (value) {
                      this.notes = value;
                    },
                    maxLength: 500,
                    expands: false,

                    // minLines: 1,

                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.5, color: Color(0xffD9ACF5)),
                      ),
                      hintText: "Enter A Message Here",
                      hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 50, 15, 0),
                  child: InkWell(
                    onTap: () {
                      createlead();
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xffA85CF9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text(
                        "ADD CLIENT",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Color(0xffECF2FF),
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
