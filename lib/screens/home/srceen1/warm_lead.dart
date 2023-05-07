import 'package:brew_crew/screens/home/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'clientside.dart';

// import 'package:get/get.dart';
// import 'package:brew_crew/screens/home/srceen1/leadmain.dart';

class Person {
  final String name;
  final String email;
  final int phoneNo;
  bool isChecked;

  Person(
      {required this.name,
      required this.email,
      required this.phoneNo,
      this.isChecked = false});
}

//CCCCCCCCHHHHHHHHHHHHHAAAAAAAAAATTTTTTTGGGGGGPPPPPPPPPPTTTTTTTTTTcHATGPT
class WarmLeads extends StatefulWidget {
  @override
  State<WarmLeads> createState() => _WarmLeadsState();
}

class _WarmLeadsState extends State<WarmLeads> {
  String salesperson = '';
  String email = '';
  int phonenumber = 0;
  bool _showButton = false;
  final CollectionReference leadsCollection =
      FirebaseFirestore.instance.collection('Leads');

  converttohot() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Leads').doc(email);
    documentReference
        .update({"activity_status": "hot"})
        .then((value) => print("Field updated"))
        .catchError((error) => print("Failed to update field: $error"));
    Navigator.pop(context);
    // documentReference.set({"activity_status": 'cold'}).whenComplete(
    //     () => {print("created")});
  }

  converttocold() {
    print('################################');
    print(email);
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Leads').doc(email);
    documentReference
        .update({"activity_status": "cold"})
        .then((value) => print("Field updated"))
        .catchError((error) => print("Failed to update field: $error"));
    Navigator.pop(context);

    // documentReference.set({"activity_status": 'cold'}).whenComplete(
    //     () => {print("created")});
  }

  void bottomsheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            // height: 670,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  dense: true,
                  title: Text(
                    'Options',
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 17,
                    ),
                  ),
                  tileColor: Colors.grey[100],
                ),
                InkWell(
                  onTap: () {
                    // converttohot();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        content: const Text(
                          'Are you sure you want to convert this lead to hot lead?',
                          style: TextStyle(
                            fontFamily: "Montserrat",
                          ),
                        ),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text(
                              'Yes',
                              style: TextStyle(color: const Color(0XffA85CF9)),
                            ),
                            onPressed: () {
                              converttohot();
                              Navigator.of(context).pop();
                            },
                          ),
                          CupertinoDialogAction(
                            child: const Text('No',
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    color: const Color(0XffA85CF9))),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: ListTile(
                    dense: true,
                    title: Row(
                      children: [
                        Icon(
                          Icons.whatshot,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Convert to HOT LEAD',
                          style: TextStyle(
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(thickness: 2, height: 5),
                InkWell(
                  onTap: () {
                    // converttocold();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        content: const Text(
                          'Are you sure you want to convert this lead to cold lead?',
                          style: TextStyle(
                            fontFamily: "Montserrat",
                          ),
                        ),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text(
                              'Yes',
                              style: TextStyle(color: const Color(0XffA85CF9)),
                            ),
                            onPressed: () {
                              converttocold();
                              Navigator.of(context).pop();
                            },
                          ),
                          CupertinoDialogAction(
                            child: const Text('No',
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    color: const Color(0XffA85CF9))),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: ListTile(
                    dense: true,
                    title: Row(
                      children: [
                        Icon(
                          Icons.whatshot,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Convert to COLD LEAD',
                          style: TextStyle(
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Warm Leads',
            style: TextStyle(fontFamily: "Montserrat", color: Colors.black),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            tooltip: 'Back',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(15, 26, 15, 10),
          child: StreamBuilder<QuerySnapshot>(
            stream: leadsCollection
                .where('activity_status', isEqualTo: 'warm')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final List<Person> people = snapshot.data!.docs.map((doc) {
                final String name = doc['name'];
                final String email = doc['email'];
                final int phoneNo = doc['phoneNo'];
                return Person(name: name, email: email, phoneNo: phoneNo);
              }).toList();

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: people.length,
                      itemBuilder: (context, index) {
                        final person = people[index];

                        return Container(
                          margin: EdgeInsets.only(
                            bottom: 10,
                          ),
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
                                offset: const Offset(
                                    0, 8), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              person.name,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                              ),
                            ),
                            subtitle: Text(person.email,
                                style: TextStyle(fontFamily: "Montserrat")),
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  salesperson = people[index].name;
                                  email = people[index].email;
                                });
                                bottomsheet(context);
                              },
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}

// void bottomsheet(BuildContext context) {
//   showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Container(
//           // height: 670,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 dense: true,
//                 title: Text(
//                   'Options',
//                   style: TextStyle(
//                     fontSize: 17,
//                   ),
//                 ),
//                 tileColor: Colors.grey[100],
//               ),
//               InkWell(
//                 onTap: () {
//                   converttohot();
//                 },
//                 child: ListTile(
//                   dense: true,
//                   title: Row(
//                     children: [
//                      Icon(
//                       Icons.whatshot,
//                       color: Colors.red,
//                     ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text('Convert to HOT LEAD'),
//                     ],
//                   ),
//                 ),
//               ),
//               Divider(thickness: 2, height: 5),
//               InkWell(
//                 onTap: () {
//                   coverttocold();
//                 },
//                 child: ListTile(
//                   dense: true,
//                   title: Row(
//                     children: [
//                       Icon(
//                       Icons.whatshot,
//                       color: Colors.grey,
//                     ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text('Convert to COLD LEAD'),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       });
// }
