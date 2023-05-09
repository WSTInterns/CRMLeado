import 'package:brew_crew/screens/home/sendfunctionalty.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SendMessage extends StatefulWidget {
  SendMessage({super.key, required this.phoneNo, required this.email});
  int phoneNo;
  String email;

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
        actions: [
          IconButton(
            onPressed: () {
              bottomsheet(context);
            },
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      backgroundColor: Color(0xffffffff),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),

            Container(
              // padding: EdgeInsets.symmetric(horizontal: 7),
              // transform: Matrix4.translationValues(0.0, -30.0, 0.0),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("message")
                    .where('uid',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: ((context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, int index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                        var title = documentSnapshot["title"];
                        var message = documentSnapshot["message"];
                        return SingleChildScrollView(
                          child: IntrinsicHeight(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SendFunction(
                                            message: message,
                                            title: title,
                                            phoneNo: widget.phoneNo,
                                            email: widget.email)));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 10,
                                  right: 15,
                                  left: 15,
                                ),
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      // color: const Color.fromRGBO(
                                      //         0, 0, 0, 0)
                                      //     .withOpacity(0.04),
                                      color:
                                          const Color.fromRGBO(50, 50, 93, 0.25)
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
                                      Icons.message_outlined,
                                      size: 27,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        title.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
              ),
            ),

            // Container(
            //   child: Text('Title:' + title.toString()),
            // )
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
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
                onTap: () {},
                child: ListTile(
                  onTap: () {},
                  dense: true,
                  title: Row(
                    children: [
                      Icon(
                        Icons.insert_drive_file,
                        size: 26,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'FILES',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                        ),
                      ),
                      // Icon(
                      //   Icons.delete,
                      //   size: 26,
                      //   color: Colors.red,
                      // ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Divider(thickness: 2, height: 5),
              InkWell(
                onTap: () {},
                child: ListTile(
                  onTap: () {},
                  dense: true,
                  title: Row(
                    children: [
                      Icon(
                        Icons.image,
                        size: 26,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'PAGES',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                        ),
                      ),
                      // Icon(
                      //   Icons.delete,
                      //   size: 26,
                      //   color: Colors.red,
                      // ),
                      SizedBox(
                        width: 10,
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
