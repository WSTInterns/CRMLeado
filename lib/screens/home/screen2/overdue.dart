import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'followmain.dart';
import 'package:get/get.dart';


class overdue extends StatefulWidget {
  const overdue({super.key});

  @override
  State<overdue> createState() => _overdueState();
}

class _overdueState extends State<overdue> {
  CollectionReference leadsCollection =
      FirebaseFirestore.instance.collection("Activities");
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Overdue',
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
                .where('Salesuid', isEqualTo: uid)
                .where('event_status', isEqualTo: 'overdue')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
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
                              '${documentSnapshot["LeadUid"]}',
                              style: TextStyle(
                                fontFamily: "Montserrat",
                              ),
                            ),
                            subtitle: Text('${documentSnapshot["LeadUid"]}',
                                style: TextStyle(fontFamily: "Montserrat")),
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
