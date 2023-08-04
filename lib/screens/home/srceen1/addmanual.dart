/*
import 'package:flutter/material.dart';

void main() {
  runApp(const manual());
}

class manual extends StatelessWidget {
  const manual({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const My(title: 'Quick Add and Send Message'),
    );
  }
}

class My extends StatefulWidget {
  const My({super.key, required this.title});

  final String title;

  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {

  void _incrementCounter() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      home: Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Go back')));
            },
          ),
          
      ),
      body: const DividerExample(),
      
    
// This trailing comma makes auto-formatting nicer for build methods.
    )

    );
      }
}
class DividerExample extends StatelessWidget {
  const DividerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

       
    );
  }
}
*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/screens/home/homescreen.dart';
import 'package:brew_crew/screens/home/client.dart';
import 'package:brew_crew/screens/home/phone.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:email_validator/email_validator.dart';


class manual extends StatefulWidget {
  manual({super.key});

  @override
  State<manual> createState() => _manualState();
}

class _manualState extends State<manual> {
  String name = '',
      email = '',
      password = '',
      notes = '',
      activity_status = 'warm';

  int phoneNo = 0;

  getName(String value) => {this.name = value};

  getPhoneNo(String value) {
    this.phoneNo = int.parse(value);

    }

  getEmail(String value) => {this.email = value};

  getNotes(String value) => {this.notes = value};

  bool isnumeric(String value){
    if (value == null || value.isEmpty){
      return false;
    }
    final number = num.tryParse(value);
    if (number == null){
      return false;
    }
    return true;
  }
  createlead() async {
    DateTime dateTime = DateTime.now();
    String formattedDate = DateFormat('d MMMM h:mm a').format(dateTime);
    DocumentReference doc =
        await FirebaseFirestore.instance.collection("Leads").doc(email);
    Map<String, dynamic> leadlist = {
      "name": name,
      "email": email,
      "phoneNo": phoneNo,
      "notes": notes,
      "activity_status": activity_status,
      "createdAt": formattedDate,
      "uid": FirebaseAuth.instance.currentUser!.uid
    };
    doc.set(leadlist).whenComplete(() => {print("created")});
  }

  final _formkey = GlobalKey<FormState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
            tooltip: 'Back',
            onPressed: () {
              //  Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HomeBar(
                        title: "",
                      )));
            },
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.only(
              top: 35.5,
            ),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16, bottom: 0, right: 15, top: 0),
                    child: Text(
                      "CLIENT NAME",
                      style: TextStyle(
                          fontFamily: "Montserrat",
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
                      onChanged: (value) => {getName(value)},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2.5, color: Color(0xffD9ACF5)),
                        ),
                        hintText: 'Enter Client Name',
                        hintStyle: TextStyle(
                          fontFamily: "Montserrat",
                        ),
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
                        if (value == null || value.isEmpty || !isnumeric(value)) {
                          return 'Please enter a phone number';
                        } else if (value.length != 10) {
                          return 'Phone number must be 10 digits';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (isnumeric(value)){
                            getPhoneNo(value);
                        }
                      },
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
                        hintText: 'Enter the Phone Number',
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
                        EdgeInsets.only(left: 16, bottom: 0, right: 15, top: 0),
                    child: Text(
                      "EMAIL ADDRESS",
                      style: TextStyle(
                          fontFamily: "Montserrat",
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
                        if (value!.isEmpty) {
                          return "Required";
                        } 
                        else if (!EmailValidator.validate(value)){
                          return "Invalid Email";
                        }
                        else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        getEmail(value);  
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          // enabledBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(color: Colors.black),
                          // ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.5, color: Color(0xffD9ACF5)),
                          ),
                          // errorBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(
                          //       width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                          // ),
                          // border: OutlineInputBorder(),
                          hintText: 'Enter the Email Address',
                          hintStyle: TextStyle(
                            fontFamily: "Montserrat",
                          )

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
                      "NOTES",
                      style: TextStyle(
                          fontFamily: "Montserrat",
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
                        if (value!.isEmpty) {
                          return "Required";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        getNotes(value);
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
                        // hintText: "Enter A Message Here",
                        hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: InkWell(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          createlead();
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => HomeBar(
                                        title: "",
                                      )));
                        }
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xff4B56D2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                            child: Text(
                          "SAVE",
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
            )));
  }
}
/*
class My extends StatefulWidget {
  const My({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
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
        appBar: AppBar(
            title: Text('ADD NEW CLIENT',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.black,
                tooltip: 'Show Snackbar',
                onPressed: () {
                // Navigator.pop(context);
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>HomePage1()));
                  })),
        body: Padding(
              padding: const EdgeInsets.only(
          top: 35.5,
        ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, bottom: 0, right: 15, top: 0),
                  child: Text(
                    "CLIENT NAME",
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
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.5, color: Color(0xffD9ACF5)),
                      ),
                      hintText: 'Enter a search term',
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
                      hintText: 'Enter the Phone Number',

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
                      hintText: 'Enter the Email Address',

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
                    "NOTES",
                    style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                 const SizedBox(
                    height: 7,
                  ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0) , 
                  child: TextFormField(
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
                      // hintText: "Enter A Message Here",
                      hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xff4B56D2),
                    ),
                    child: const Center(
                        child: Text(
                      "SAVE",
                      style: TextStyle(
                        color: Color(0xffECF2FF),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                ),
              ],
            )));
  }
}
*/
/*
import 'package:flutter/material.dart';  
  
void main() {  
  runApp(MaterialApp( home: manual(),));  
}  
  
class manual extends StatefulWidget {  
  @override  
  _State createState() => _State();  
}  
  
class _State extends State<manual> {  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
        appBar: AppBar(  
          title: Text('Flutter TextFormField Example'),  
        ),  
        body: Padding(  
            padding: EdgeInsets.all(15),  
            child: Column(  
              children: <Widget>[  
                Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextFormField(  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'User Name',  
                      hintText: 'Enter Your Name',  
                    ),  
                  ),  
                ),  
                Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextFormField(  
                    obscureText: true,  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Password',  
                      hintText: 'Enter Password',  
                    ),  
                  ),  
                ),  

              ],  
            )  
        )  
    );  
  }  
}  
*/

