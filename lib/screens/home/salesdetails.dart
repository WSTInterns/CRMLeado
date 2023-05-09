import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class salesdetails extends StatefulWidget {
  const salesdetails(
      {super.key,
      required this.name,
      required this.email,
      required this.phoneNo,
      required this.product_name,
      required this.category,
      required this.quantity});
  final String name, email, product_name, category;
  final int phoneNo, quantity;

  @override
  State<salesdetails> createState() => _salesdetailsState();
}

class _salesdetailsState extends State<salesdetails> {
  var items = ['Phone Call', 'Message', 'Meet', 'Note'];
  final timeController = TextEditingController();
  late String _selectedProduct = '';
  final List<String> _productList = ['Phone Call', 'Message', 'Meet', 'Note'];
  Map<String, dynamic> formDetails = {};

  void initState() {
    super.initState();
    _selectedProduct = '_productList[0]';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(context);
            // Navigator.push(
            // context,
            // MaterialPageRoute(
            //     builder: (context) => Moree()));
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Edit Sales Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
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
                      initialValue: widget.name,
                      enabled: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 4, color: Color(0xffD9ACF5)),
                        ),
                        hintText: widget.name,
                      ),
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
                      initialValue: '${widget.phoneNo}',
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 4, color: Color(0xffD9ACF5)),
                        ),
                        hintText: '${widget.phoneNo}',
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
                      initialValue: widget.email,
                      enabled: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 4, color: Color(0xffD9ACF5)),
                        ),
                        hintText: widget.email,
                      ),
                      onChanged: (value) => formDetails['email'] = value.trim(),
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
                      validator: (value) {
                        if (_selectedProduct == null) {
                          return 'REQUIRED';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2.5, color: Color(0xffD9ACF5)),
                        ),
                        hintText: widget.product_name,
                      ),
                      items: <String>[
                        'Product A',
                        'Product B',
                        'Product C',
                        'Product D'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        formDetails['item'] = newValue?.trim();
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
                      initialValue: widget.category,
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
                        hintText: widget.category,
                      ),
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
                      initialValue: '${widget.quantity}',
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
                        hintText: '${widget.quantity}',

                        // hintText: 'Ent',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 20, 6, 0),
                    child: InkWell(
                      onTap: () {
                        // FirebaseFirestore.collection('collectionName').doc('documentName').set(formDetails);
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Color(0xff4B56D2),
                            borderRadius: BorderRadius.circular(10)),
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
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
