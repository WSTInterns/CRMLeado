import 'package:brew_crew/screens/home/more.dart';
import 'package:brew_crew/screens/home/srceen1/upload_excel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:brew_crew/screens/home/srceen1/pb.dart';
import 'package:brew_crew/screens/home/srceen1/addmanual.dart';
import 'salesdetails.dart';


class convertedsales extends StatefulWidget {
  static const IconData remove_circle_outline =
      IconData(0xe518, fontFamily: 'MaterialIcons');

  @override
  State<convertedsales> createState() => _convertedsalesState();
}

class _convertedsalesState extends State<convertedsales> {
  //const convertedsales({super.key});
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  String name='', email='';
  int phoneNo=0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (isDialOpen.value) {
            isDialOpen.value = false;
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
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

          title: Text(
              "SALES",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                // fontSize: 22,
              
            ),
          ),
          backgroundColor: Color(0xff),
          elevation: 0,
        ),
       
          body: Padding(
            padding: const EdgeInsets.fromLTRB(15, 23, 15, 0),
            child: Container(
              alignment: Alignment.topCenter,
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("Sales").snapshots(),
                builder: ((context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, int index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];

                        // var clientName = documentSnapshot["name"];
                        return GestureDetector(
                          onTap: () {
                            print("I'm a disco dancer");
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) => salesdetails(
                                  name: documentSnapshot["name"],
                                  email:documentSnapshot["email"],  
                                  phoneNo: documentSnapshot["phoneNo"],
                                  product_name: documentSnapshot["product_name"],
                                  category: documentSnapshot["category"],
                                  quantity: documentSnapshot["quantity"],

 )));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 10,
                            ),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
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
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 27,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    documentSnapshot["name"].toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
              ),
            ),

            // body: Container(
            //   alignment: Alignment.center,
            //   child: StreamBuilder<QuerySnapshot>(
            //         stream:
            //             FirebaseFirestore.instance.collection("Leads").snapshots(),
            //         builder: ((context, AsyncSnapshot snapshot) {
            //           if (snapshot.hasData) {
            //             return ListView.builder(
            //               shrinkWrap: true,
            //               itemCount: 4,
            //               itemBuilder: ((context, int index) {
            //                 DocumentSnapshot documentSnapshot =
            //                     snapshot.data!.docs[index];
            //                 return Row(
            //                   children: [
            //                     Expanded(
            //                       child: Text(documentSnapshot["name"]),
            //                     ),

            //                   ],
            //                 );
            //               }),
            //             );
            //           } else {
            //             return CircularProgressIndicator();
            //           }
            //         }),
            //       ),

            // ),
          ),
        ));
  }
}