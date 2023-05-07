import 'package:brew_crew/screens/home/screen3/editmessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../homescreen.dart';

class MessageContentPage extends StatelessWidget {
  MessageContentPage({super.key, required this.message, required this.title});
  String message, title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Message title",
          style: TextStyle(
              fontFamily: "Montserrat",
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              bottomsheet(context, message, title);
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
        body: Padding(
          padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  // color: const Color.fromRGBO(
                  //         0, 0, 0, 0)
                  //     .withOpacity(0.04),
                  color: const Color.fromRGBO(50, 50, 93, 0.25).withOpacity(0.08),
                  // color:
                  //     const Color.fromRGBO(50, 50, 93, 0.25).withOpacity(0.1),
                  spreadRadius: 10,
                  blurRadius: 20,
                  offset: const Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Text(
              message,
              style: TextStyle(
                fontFamily: "Montserrat",
              ),
            ),
          ),
        ),
    );
  }
}

void bottomsheet(BuildContext context, String message, String title) {
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
                  onTap: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => EditMessageContent(
                              message: message,
                              title: title,
                            )))
                  },
                  dense: true,
                  title: Row(
                    children: [
                      Icon(
                        Icons.edit_note,
                        size: 28,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Edit Message Content',
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
                onTap: () {},
                child: ListTile(
                  onTap: () {
                    DocumentReference _docref = FirebaseFirestore.instance
                        .collection("message")
                        .doc(title);
                    _docref.delete();
                    print('${title} deleted');
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  dense: true,
                  title: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        size: 26,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Delete Message Template',
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
