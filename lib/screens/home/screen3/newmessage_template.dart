import 'package:brew_crew/screens/home/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(NewTemplate());
}

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: NewTemplate());
//   }
// }

class NewTemplate extends StatefulWidget {
  // List<Data> data = List.empty(growable: true);

  // NewTemplate({required this.data});

  @override
  State<NewTemplate> createState() => _NewTemplateState();
}

class _NewTemplateState extends State<NewTemplate> {
  // TextEditingController titleController = TextEditingController();
  // String title = '';
  // TextEditingController messageController = TextEditingController();
  // String message = '';

  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();

  String message = '', title = '';

  late String form1Value;
  late String form2Value;

  getMessage(String message) {
    this.message = message;
  }

  getTitle(String title) {
    this.title = title;
  }

  createMessage() async {
    DocumentReference doc =
        await FirebaseFirestore.instance.collection("message").doc(title);
    Map<String, dynamic> messages = {
      "title": title,
      "message": message,
      "uid": FirebaseAuth.instance.currentUser!.uid
    };
    doc.set(messages).whenComplete(() => {print("Saved Message")});
  }

  // void validate() {
  //   if (_formkey1.currentState!.validate()) {
  //     print('ok');
  //   } else {
  //     print('Error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text('New Message Template',
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
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (BuildContext context) => HomeBar(
                //           title: "",
                //         )));
                Navigator.pop(context);
              })),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 20, 4),
                child: Text(
                  "TITLE",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Form(
                key: _formkey1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: TextFormField(
                    onChanged: (value) => getTitle(value),

                    // controller: titleController,

                    validator: (value) {
                      // if (value == null || value.isEmpty) {
                      //   return 'Please enter some text';
                      // }
                      // return null;
                      if (value!.isEmpty) {
                        return "Required";
                      } else {
                        return null;
                      }
                      ;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2.5, color: Color(0xffD9ACF5)),
                        ),
                        hintText: 'e.g.Ask for coffee in next 3 days',
                        hintStyle: TextStyle(
                          fontFamily: "Montserrat",
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 23,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 20, 2),
                child: Text(
                  "TEMPLATE MESSAGE",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Form(
                key: _formkey2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: TextFormField(
                    onChanged: (value) => getMessage(value),
                    maxLines: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.5, color: Color(0xffD9ACF5)),
                      ),
                      hintText: 'Hi @clientname...',
                      hintStyle: TextStyle(
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: InkWell(
                  onTap: () {
                    bool _form1Valid = _formkey1.currentState!.validate();
                    bool _form2Valid = _formkey2.currentState!.validate();

                    if (_form1Valid && _form2Valid) {
                      _formkey1.currentState!.save();
                      _formkey2.currentState!.save();
                      createMessage();
                      Navigator.pop(context);
                    }
                    //////////////////////////////////////////////////////
                    // FirebaseFirestore.collection('collectionName').doc('documentName').set(formDetails);
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xff4B56D2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: Text(
                      "CREATE MESSAGE",
                      style: TextStyle(
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
      ),
    );
  }
}
