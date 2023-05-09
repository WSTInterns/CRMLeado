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
class HotLeads extends StatefulWidget {
  @override
  State<HotLeads> createState() => _HotLeadsState();
}

class _HotLeadsState extends State<HotLeads> {
  String salesperson = '';
  String salesmail = '';
  int phonenumber = 0;
  bool _showButton = false;
  final CollectionReference leadsCollection =
      FirebaseFirestore.instance.collection('Leads');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Hot Leads',
            style: TextStyle(color: Colors.black, fontFamily: "Montserrat"),
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
                .where('activity_status', isEqualTo: 'hot')
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
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              people[index].isChecked =
                                  !people[index].isChecked;
                              _showButton =
                                  people.any((person) => person.isChecked);
                            });
                          },
                          child: Container(
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
                            child: CheckboxListTile(
                              value: person.isChecked,
                              title: Text(
                                person.name,
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                ),
                              ),
                              subtitle: Text(person.email,
                                  style: TextStyle(fontFamily: "Montserrat")),
                              onChanged: (value) {
                                // Update the isChecked value of the person
                                person.isChecked = value ?? false;

                                // Rebuild the widget tree to reflect the change
                                setState(() {
                                  if (people[index].isChecked) {
                                    people
                                        .where(
                                            (person) => person != people[index])
                                        .forEach((person) =>
                                            person.isChecked = false);
                                  }
                                  _showButton =
                                      people.any((person) => person.isChecked);
                                  salesperson = people[index].name;
                                  salesmail = people[index].email;
                                });
                              },
                              activeColor: Color(0Xff4B56D2),
                              checkColor: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (people.any((person) => person.isChecked))
                    ElevatedButton(
                      onPressed: () {
                        // Remove checked items
                        people.removeWhere((person) => person.isChecked);

                        // Rebuild the widget tree to reflect the change
                        setState(() {});
                      },
                      child: const Text(
                        'Remove Selected',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ),
                  if (_showButton)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              content: const Text(
                                'Do you want to convert these lead to sales?',
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                ),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(
                                        color: const Color(0Xff4B56D2)),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                            builder: (context) => HomePage(
                                                  title: 'Client Details',
                                                  email: salesmail,
                                                  salesnamefinal: salesperson,
                                                  phone: phonenumber,
                                                ))); //abcd
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: const Text('No',
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          color: const Color(0Xff4B56D2))),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text('ADD TO SALES',
                            style: TextStyle(
                              fontFamily: "Montserrat",
                            )),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0Xff4B56D2)),
                          minimumSize: MaterialStateProperty.all(Size(600, 50)),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ));
  }
}
