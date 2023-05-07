// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:io';

// class UploadFile extends StatefulWidget {
//   const UploadFile({super.key});

//   @override
//   State<UploadFile> createState() => _UploadFileState();
// }

// class _UploadFileState extends State<UploadFile> {
//   File? pdffile;

import 'dart:typed_data';
import 'package:brew_crew/screens/home/contents.dart';
import 'package:brew_crew/screens/home/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class UploadFile extends StatefulWidget {
  const UploadFile({Key? key});

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  File? _selectedFile;
  final TextEditingController _fileTitleController = TextEditingController();
  String name = '';
  Future<void> _uploadFile() async {
    if (_selectedFile != null) {
      Uint8List fileData = await _selectedFile!.readAsBytes();
      String pdfId = Uuid().v4();
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageRef = storage.ref().child('pdfs/$pdfId.pdf');
      UploadTask uploadTask = storageRef.putData(fileData);
      String pdfUrl =
          await uploadTask.then((value) => value.ref.getDownloadURL());
      CollectionReference pdfCollection =
          FirebaseFirestore.instance.collection('pdfs');
      await pdfCollection.add({
        'createdAt': Timestamp.now(),
        'name': name,
        'salesPersonUid': FirebaseAuth.instance.currentUser!.uid,
        'url': pdfUrl,
      });
    }
  }

  @override
  void dispose() {
    _fileTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        title: Text('Upload File',
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
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              SizedBox(
                height: 35,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "FILE TITLE",
                    style: TextStyle(
                        fontFamily: "Montserrat", fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                    name = value;
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
                    hintText: 'Enter the File Title',

                    // hintText: 'Ent',
                  ),
                ),
              ),
              Container(
                // width: 200,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 25),
                  child: InkWell(
                    onTap: () async {
                      {
                        final result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf', 'doc']);
                        if (result != null) {
                          final path = result.files.single.path;
                          setState(
                            () {
                              _selectedFile = File(path!);
                            },
                          );
                        }
                      }
                    },
                    child: Container(
                      // margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xffA85CF9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "UPLOAD FILE",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Color(0xffECF2FF),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 360,
              ),

              // ElevatedButton.icon(
              //   onPressed: () {},
              //   label: Text('Save File', style: TextStyle(color: Colors.white)),
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all(
              //       Color(0xffA85CF9),
              //     ),
              //   ),
              //   icon: Icon(Icons.save_rounded),
              // ),
              Container(
                // width: 200,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 25),
                  child: InkWell(
                    onTap: () async {
                      _uploadFile();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('File added successfully!')));
                    },
                    child: Container(
                      // margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xffA85CF9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "SAVE FILE",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Color(0xffECF2FF),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
