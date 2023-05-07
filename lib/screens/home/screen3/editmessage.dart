import 'package:brew_crew/screens/home/screen3/message_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditMessageContent extends StatefulWidget {
  EditMessageContent({super.key, required this.message, required this.title});
  String message, title;

  @override
  State<EditMessageContent> createState() => _EditMessageContentState();
}

class _EditMessageContentState extends State<EditMessageContent> {
  String convertNewLine(String content) {
    print("Converting");
    return content.replaceAll(r'\n', '\n');
  }

  TextEditingController tec = TextEditingController();

  void editmessage() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('message').doc(widget.title);
    documentReference
        .update({"message": widget.message})
        .then((value) => print("Field updated"))
        .catchError((error) => print("Failed to update field: $error"));
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.title}",
          style: TextStyle(fontFamily: "Montserrat", color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          SizedBox(
            width: 10,
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          tooltip: 'Back',
          onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => MessageContentPage(
            //               message: convertNewLine(widget.message),
            //               title: widget.title,
            //             )));
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 20),
            child: Container(
              padding:const EdgeInsets.all(10),
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
                    offset: const Offset(0, 8), // changes position of shadow
                  ),
                ],
              ),
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  child: TextFormField(
                    maxLines: null, // Allows for unlimited lines of text
                    keyboardType: TextInputType.multiline,
                    onChanged: ((value) => widget.message = value),
                    initialValue: convertNewLine(widget.message),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'e.g.Your Message',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: InkWell(
              onTap: () {
                if (_formkey.currentState!.validate()) {
                  editmessage();
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xffA85CF9),
                  borderRadius: BorderRadius.circular(10),
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
          ),
        ],
      ),
    );
  }
}
