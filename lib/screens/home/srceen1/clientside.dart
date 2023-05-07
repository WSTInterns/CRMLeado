import 'dart:io';
import 'package:brew_crew/screens/home/srceen1/leadmain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'hot_lead.dart';
import 'package:flutter/src/material/dropdown.dart';

// class MyAppShrey extends StatelessWidget {
//    const MyAppShrey({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(

//         primarySwatch: Colors.blue,
//       ),
//       home:  HomePage(title: 'Client Details',email:'email',salesnamefinal: 'name',phone: 7620,),
//     );
//   }
// }

class HomePage extends StatefulWidget {
//  String  name, email,phone;
  // const HomePage({Key? key, required this.title});
  ///Homepage({required this.name,required this.email,required this.phone});
  const HomePage(
      {Key? key,
      required this.title,
      required this.email,
      required this.salesnamefinal,
      required this.phone})
      : super(key: key);

  final String title;
  final String salesnamefinal;
  final int phone;
  final String email;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _selectedProduct = '', category = '', product = '';
  int quantity = 0;
  final List<String> _products = ['Product A', 'Product B', 'Product C'];
  Map<String, dynamic> formDetails = {};
  final formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _selectedProduct = '_products[0]';
  }

  converttosales() {
    String name = widget.salesnamefinal, email = widget.email;
    int phone = widget.phone;
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Sales').doc(widget.email);
    Map<String, dynamic> details = {
      "name": name,
      "email": email,
      "phoneNo": phone,
      "category": category,
      "product_name": _selectedProduct,
      "quantity": quantity,
    };
    documentReference.set(details).whenComplete(() => {print("created")});
  }

  removefromhot() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Leads').doc(widget.email);
    documentReference
        .update({"activity_status": "cold"})
        .then((value) => print("Field updated"))
        .catchError((error) => print("Failed to update field: $error"));
    documentReference.set({"activity_status": 'cold'}).whenComplete(
        () => {print("created")});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(
              fontFamily: "Montserrat",
              color: Colors.black,
              fontStyle: FontStyle.normal,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.black,
              tooltip: 'Go back',
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => HotLeads()));
              }),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, bottom: 0, right: 20, top: 20),
                      child: Text(
                        "NAME",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      child: TextFormField(
                        enabled: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 4, color: Color(0xffD9ACF5)),
                          ),
                          hintText: widget.salesnamefinal,
                        ),
                        onChanged: (value) =>
                            formDetails['name'] = value.trim(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15, bottom: 0, right: 20, top: 20),
                      child: Text(
                        "PHONE NUMBER",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
                        enabled: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 4, color: Color(0xffD9ACF5)),
                          ),
                          hintText: '${widget.phone}',
                        ),
                        onChanged: (value) =>
                            formDetails['phoneNumber'] = value.trim(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15, bottom: 0, right: 20, top: 20),
                      child: Text(
                        "EMAIL",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      child: TextFormField(
                        enabled: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 4, color: Color(0xffD9ACF5)),
                          ),
                          hintText: widget.email,
                        ),
                        onChanged: (value) =>
                            formDetails['email'] = value.trim(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15, bottom: 0, right: 20, top: 20),
                      child: Text(
                        "PRODUCT",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 4, color: Color(0xffD9ACF5)),
                          ),
                          hintText: 'Select a product',
                        ),
                        items: <String>[
                          'Product A',
                          'Product B',
                          'Product C',
                          'Product D'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                )),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          this._selectedProduct = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15, bottom: 0, right: 20, top: 20),
                      child: Text(
                        "PRODUCT CATEGORY",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 4, color: Color(0xffD9ACF5)),
                          ),
                          hintText: 'Enter the product category',
                        ),
                        onChanged: (value) => this.category = value,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15, bottom: 0, right: 20, top: 20),
                      child: Text(
                        "PRODUCT QUANTITY",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          // enabledBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(color: Colors.black),
                          // ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 4, color: Color(0xffD9ACF5)),
                          ),
                          // errorBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(
                          //       width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                          // ),
                          // border: OutlineInputBorder(),
                          hintText: 'Enter the Quantity of Product',

                          // hintText: 'Ent',
                        ),
                        onChanged: (value) => this.quantity = int.parse(value),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (formGlobalKey.currentState!.validate()) {
                          converttosales();
                          removefromhot();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      HotLeads()));
                        }
                        // FirebaseFirestore.collection('collectionName').doc('documentName').set(formDetails);
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color(0xffA85CF9),
                        ),
                        child: const Center(
                            child: Text(
                          "SAVE & NEXT",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Color(0xffECF2FF),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
