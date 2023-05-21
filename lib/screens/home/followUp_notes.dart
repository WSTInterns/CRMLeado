import 'package:brew_crew/screens/home/screen2/notes.dart';
import 'package:brew_crew/screens/home/screen3/message_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FollowUpNotes extends StatefulWidget {
  FollowUpNotes(
      {super.key,
      required this.name,
      required this.email,
      required this.phoneNo});
  final String name, email;
  final int phoneNo;
  @override
  State<FollowUpNotes> createState() => _FollowUpNotes();
}

class _FollowUpNotes extends State<FollowUpNotes> {
  String convertNewLine(String content) {
    print("Converting");
    return content.replaceAll(r'\n', '\n');
  }

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotes();
    print('initialized');
  }

  void getNotes() {
  DocumentReference docRef =
      FirebaseFirestore.instance.collection('Leads').doc(widget.email);

  docRef.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      String? fetchedNotes = documentSnapshot.get('notes') as String?;
      setState(() {
        tec.text = fetchedNotes ?? '';
      });
    }
  }).catchError((error) {
    print('Error fetching document: $error');
  });
}

void editNotes(String newNotes) {
  DocumentReference docRef =
      FirebaseFirestore.instance.collection('Leads').doc(widget.email);

  docRef.update({'notes': newNotes}).then((value) {
    print('Notes updated successfully');
  }).catchError((error) {
    print('Error updating notes: $error');
  });
}



  TextEditingController tec = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NOTES",
          style: TextStyle(fontFamily: "Montserrat", color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          SizedBox(
            width: 10,
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          tooltip: 'Back',
          onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => MessageContentPage(
            //               message: convertNewLine(widget.message),
            //               title: widget.title,
            //             )));
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 30, 15, 20),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    // color: const Color.fromRGBO(
                    //         0, 0, 0, 0)
                    //     .withOpacity(0.04),
                    color: const Color.fromRGBO(50, 50, 93, 0.25)
                        .withOpacity(0.08),
                    // color:
                    //     const Color.fromRGBO(50, 50, 93, 0.25).withOpacity(0.1),
                    spreadRadius: 10,
                    blurRadius: 20,
                    offset: const Offset(0, 8), // changes position of shadow
                  ),
                ],
              ),
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  child: TextFormField(
                    maxLines: null, // Allows for unlimited lines of text
                    keyboardType: TextInputType.multiline,
                    
                    
                    // onChanged: ((value) => widget.message = value),
                    //initialValue: convertNewLine(widget.message),
                    controller: tec,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'e.g.Your Message',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: InkWell(
              onTap: () {
  if (_formkey.currentState!.validate()) {
    editNotes(tec.text);
    Navigator.pop(context);
  }
},

              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Color(0xff4B56D2),
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                      color: Color(0xffECF2FF),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
