import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:firestore_storage';

//import 'package:validate/main.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleName = TextEditingController();
  final TextEditingController DescriptionName = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? pickedImage;
  String base64Image = "";
  String imageUrl = "";
  CollectionReference _reference =
      FirebaseFirestore.instance.collection('pages');
  // TextEditingController _addItemController = TextEditingController();
  // late DocumentReference linkRef;
  // List<String> videoID = [];
  // bool showItem = false;
  // final utube =
  //     RegExp(r"^(https?\:\/\/)?((www\.)?youtube\.com|youtu\.?be)\/.+$");
  // File? selectedImage;
  // String base64Image = "";

  // Future<void> _chooseImage(type) async {
  //   // ignore: prefer_typing_uninitialized_variables
  //   var image;
  //   if (type == "camera") {
  //     image = await ImagePicker()
  //         .pickImage(source: ImageSource.camera, imageQuality: 10);
  //   } else {
  //     image = await ImagePicker()
  //         .pickImage(source: ImageSource.gallery, imageQuality: 25);
  //   }
  //   if (image != null) {
  //     setState(() {
  //       selectedImage = File(image.path);
  //       base64Image = base64Encode(selectedImage!.readAsBytesSync());
  //       // won't have any error now
  //     });
  //   }
  // }

  // void _showActionSheet(BuildContext context) {
  //   showCupertinoModalPopup<void>(
  //     context: context,
  //     builder: (BuildContext context) => CupertinoActionSheet(
  //       title: const Text(
  //         'Add photos',
  //         textAlign: TextAlign.left,
  //       ),
  //       actions: <CupertinoActionSheetAction>[
  //         CupertinoActionSheetAction(

  //             /// This parameter indicates the action would be a default
  //             /// defualt behavior, turns the action's text to bold text.

  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: Row(
  //               children: [
  //                 Padding(
  //                     padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
  //                     child: Icon(Icons.camera)),
  //                 Padding(
  //                   padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
  //                   child: Text("Take from camera"),
  //                 )
  //               ],
  //             )),
  //         CupertinoActionSheetAction(
  //             onPressed: () {
  //               Navigator.pop(_chooseImage("camera"));
  //             },
  //             child: Row(
  //               children: [
  //                 Padding(
  //                     padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
  //                     child: Icon(Icons.photo)),
  //                 Padding(
  //                   padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
  //                   child: Text("Select from gallery"),
  //                 )
  //               ],
  //             )),
  //       ],
  //     ),
  //   );
  // }

  // void imagePickerOption() {
  //   Get.bottomSheet(
  //     SingleChildScrollView(
  //       child: ClipRRect(
  //         borderRadius: const BorderRadius.only(
  //           topLeft: Radius.circular(10.0),
  //           topRight: Radius.circular(10.0),
  //         ),
  //         child: Container(
  //           color: Colors.white,
  //           height: 250,
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.stretch,
  //               children: [
  //                 const Text(
  //                   "Pic Image From",
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //                 ElevatedButton.icon(
  //                   onPressed: () {
  //                     pickImage(ImageSource.camera);
  //                   },
  //                   icon: const Icon(Icons.camera),
  //                   label: const Text("CAMERA"),
  //                 ),
  //                 ElevatedButton.icon(
  //                   onPressed: () {
  //                     pickImage(ImageSource.gallery);
  //                   },
  //                   icon: const Icon(Icons.image),
  //                   label: const Text("GALLERY"),
  //                 ),
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //                 ElevatedButton.icon(
  //                   onPressed: () {
  //                     Get.back();
  //                   },
  //                   icon: const Icon(Icons.close),
  //                   label: const Text("CANCEL"),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  // void initState() {
  //   linkRef = FirebaseFirestore.instance.collection('pages').doc('urls');
  //   super.initState();
  // }

  // _addItemFuntion() async {
  //   await linkRef.set({
  //     _addItemController.text.toString(): _addItemController.text.toString()
  //   }, SetOptions(merge: true));
  //   Flushbar(
  //       title: 'Added',
  //       message: 'updating...',
  //       duration: Duration(seconds: 3),
  //       icon: Icon(Icons.info_outline))
  //     ..show(context);
  //   setState(() {
  //     videoID.add(_addItemController.text);
  //   });
  //   print('added');
  //   FocusScope.of(this.context).unfocus();
  //   _addItemController.clear();
  // }

  void _bottomsheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (contxt) {
          return Container(
            color: Color(0xFF737373),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              height: 200,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text(
                      'Add Photos',
                      style: TextStyle(
                        fontFamily: "Montserrat",
                      ),
                    ),
                    // onTap: () {
                    //   // Navigator.pop(context);
                    //   pickImage(ImageSource.gallery);
                    // },
                  ),
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text(
                      'Take from camera',
                      style: TextStyle(
                        fontFamily: "Montserrat",
                      ),
                    ),
                    onTap: () {
                      // Navigator.pop(context);
                      pickImage(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text(
                      'Select from gallery',
                      style: TextStyle(
                        fontFamily: "Montserrat",
                      ),
                    ),
                    onTap: () {
                      // Navigator.pop(context);
                      pickImage(ImageSource.gallery);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  void _bottomsheett(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (contxt) {
          return SafeArea(
            child: Container(
              color: Color(0xFF737373),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                //height: 200,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Add YouTube Video'),
                      subtitle: Text('Insert a YouTube video link below'),
                      // onTap: () {
                      //   // Navigator.pop(context);
                      //   pickImage(ImageSource.gallery);
                      // },
                    ),
                    // ProgressHUD(
                    //     key: UniqueKey(),
                    //     child: pageUI(),
                    //     inAsyncCall: isApiCallProcess,
                    //     opacity: 0.3),

                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: TextField(
                        //controller: _urlController,
                        decoration: InputDecoration(
                          labelText: 'Enter YouTube video URL',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 92, 93, 95)),
                          ),
                        ),
                      ),
                    ),

                    ElevatedButton(
                      // onPressed: _getVideoInfo,
                      onPressed: () {},
                      child: Text('Get Video Info'),
                    ),
                    // if (_title.isNotEmpty)
                    //   Padding(
                    //     padding: EdgeInsets.all(16.0),
                    //     child: Column(
                    //       children: [
                    //         Text(
                    //           _title,
                    //           style: TextStyle(
                    //             fontSize: 24.0,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //         if (_thumbnailUrl.isNotEmpty)
                    //           Image.network(_thumbnailUrl),
                    //       ],
                    //     ),
                    //   ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      //print('${photo.path}');
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('images');
      Reference referenceImageToUpload =
          referenceDirImages.child(uniqueFileName);
      //store the file
      await referenceImageToUpload.putFile(File(photo.path));
      //get download url
      imageUrl = await referenceImageToUpload.getDownloadURL();
      print('${imageUrl}');
      print("image value is null");
      setState(() {
        pickedImage = tempImage;
        base64Image = base64Encode(pickedImage!.readAsBytesSync());
      });
      //print('${photo.path}');

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Product or Event Page',
              style: TextStyle(
                  fontFamily: "Montserrat",
                  color: Color.fromARGB(255, 15, 10, 10),
                  fontWeight: FontWeight.bold)),
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.black,
              tooltip: 'Show Snackbar',
              onPressed: () {
                Navigator.pop(context);
              })),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 25, 0, 7),
              child: Text(
                "TITLE",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
            // const ListTile(
            //   leading: Text(
            //     "TITLE",
            //     style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            //   ),
            //   trailing: Text("*Required"),
            // ),

            const SizedBox(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: TextFormField(
                controller: titleName,
                decoration: InputDecoration(
                  hintText: "Enter Title",
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2.5, color: Color(0xffD9ACF5)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    borderSide: const BorderSide(),
                  ),
                  hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 23, 0, 7),
              child: Text(
                "DESCRIPTION",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // const ListTile(
            //   leading: Text(
            //     "DESCRIPTION",
            //     style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            //     textAlign: TextAlign.left,
            //   ),
            // ),

            // Padding(
            //   padding:
            //       EdgeInsets.only(left: 15, bottom: 0, right: 20, top: 20),
            //   child: Text(
            //     "ENTER THE MESSAGE",
            //     style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            //     textAlign: TextAlign.left,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: DescriptionName,
                maxLength: 500,
                expands: false,

                // minLines: 1,

                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: "Add description about your product or event...",
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2.5, color: Color(0xffD9ACF5)),
                  ),
                  // hintText: "Enter A Message Here",
                  hintStyle: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 17,
                      color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(18, 25, 0, 7),
              child: Text(
                "UPLOAD IMAGE",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
            ),

            //container

            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: InkWell(
                //onTap: () => _showActionSheet(context),
                onTap: () => _bottomsheet(context),
                child: Container(
                  // margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 92, 93, 95)),
                    borderRadius: BorderRadius.circular(8),
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
                        offset:
                            const Offset(0, 8), // changes position of shadow
                      ),
                    ],
                  ),

                  width: 48.0,
                  height: 80.0,

                  //
                  child: pickedImage != null
                      ? Image.file(
                          pickedImage!,
                          width: 170,
                          height: 170,
                          fit: BoxFit.cover,
                        )
                      // : Image.network(
                      //     'https://upload.wikimedia.org/wikipedia/commons/5/5f/Alberto_conversi_profile_pic.jpg',
                      //     width: 170,
                      //     height: 170,
                      //     fit: BoxFit.cover,
                      //   ),
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            //   child: const Icon(Icons.add),
                            // ),
                            const Icon(
                              Icons.photo_album_outlined,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            // const Icon(Icons.add),
                            Text('Add Photos')
                          ],
                        ),
                ),
              ),
            ),
            // validator: (value) {
            //       if (value == null || value.isEmpty) {
            //         return 'Please enter some text';
            //       }
            //       return null;
            //     },
            // Padding(
            //   padding: const EdgeInsets.all(5),
            //   child: Container(
            //     margin: const EdgeInsets.all(3),
            //     decoration: BoxDecoration(
            //       border: Border.all(color: Color.fromARGB(255, 92, 93, 95)),
            //       borderRadius: BorderRadius.all(Radius.circular(3)),
            //     ),
            //     child: InkWell(
            //       //onTap: () => _showActionSheet(context),
            //       onTap: () => _bottomsheett(context),
            //       child: Container(
            //         margin: const EdgeInsets.all(10.0),
            //         color: Color(0xffffffff),
            //         width: 48.0,
            //         height: 40.0,

            //         //
            //         child: pickedImage != null
            //             ? Image.file(
            //                 pickedImage!,
            //                 width: 170,
            //                 height: 170,
            //                 fit: BoxFit.cover,
            //               )
            //             // : Image.network(
            //             //     'https://upload.wikimedia.org/wikipedia/commons/5/5f/Alberto_conversi_profile_pic.jpg',
            //             //     width: 170,
            //             //     height: 170,
            //             //     fit: BoxFit.cover,
            //             //
            //             : Row(
            //                 children: [
            //                   const Icon(Icons.add),
            //                   const Icon(Icons.youtube_searched_for),
            //                   Text('Add YouTube Video'),
            //                 ],
            //               ),
            //       ),
            //     ),
            //   ),
            // ),

            // Column(
            //   children: [
            //     Container(
            //       margin: EdgeInsets.symmetric(horizontal: 8),
            //       child: TextField(
            //         controller: _addItemController,
            //         onEditingComplete: () {
            //           if (utube.hasMatch(_addItemController.text)) {
            //             _addItemFuntion();
            //           } else {
            //             FocusScope.of(this.context).unfocus();
            //             _addItemController.clear();
            //             Flushbar(
            //               title: 'Invalid Link',
            //               message: 'Please provide a valid link',
            //               duration: Duration(seconds: 3),
            //               icon: Icon(
            //                 Icons.error_outline,
            //                 color: Colors.red,
            //               ),
            //             )..show(context);
            //           }
            //         },
            //         style: TextStyle(fontSize: 16),
            //         decoration: InputDecoration(
            //             labelText: 'Your Video URL',
            //             suffixIcon: GestureDetector(
            //               child: Icon(Icons.add, size: 32),
            //               onTap: () {
            //                 if (utube.hasMatch(_addItemController.text)) {
            //                   _addItemFuntion();
            //                 } else {
            //                   FocusScope.of(this.context).unfocus();
            //                   _addItemController.clear();
            //                   Flushbar(
            //                     title: 'Invalid Link',
            //                     message: 'Please provide a valid link',
            //                     duration: Duration(seconds: 3),
            //                     icon: Icon(
            //                       Icons.error_outline,
            //                       color: Colors.red,
            //                     ),
            //                   )..show(context);
            //                 }
            //               },
            //             )),
            //       ),
            //     ),
            //     Flexible(
            //         child: Container(
            //             margin: EdgeInsets.symmetric(horizontal: 4),
            //             child: ListView.builder(
            //                 itemCount: videoID.length,
            //                 itemBuilder: (context, index) => Container(
            //                       margin: EdgeInsets.all(8),
            //                       child: YoutubePlayer(
            //                         controller: YoutubePlayerController(
            //                             initialVideoId:
            //                                 YoutubePlayer.convertUrlToId(
            //                                     videoID[index])!,
            //                             flags: YoutubePlayerFlags(
            //                               autoPlay: false,
            //                             )),
            //                         showVideoProgressIndicator: true,
            //                         progressIndicatorColor: Colors.blue,
            //                         progressColors: ProgressBarColors(
            //                             playedColor: Colors.blue,
            //                             handleColor: Colors.blueAccent),
            //                       ),
            //                     )))),
            //   ],
            // ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 25, 15, 0),
              child: ElevatedButton(
                onPressed: () async {
                  // if (!imageUrl.isEmpty) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(content: Text('Please upload an image')));

                  //   return;
                  // }
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    String tName = titleName.text;
                    String dName = DescriptionName.text;
                    Map<String, String> dataToSend = {
                      'title': tName,
                      'description': dName,
                      'images': imageUrl,
                    };
                    _reference.add(dataToSend);
                    Navigator.pop(context);
                    // print("Validated");
                    // print(titleName.text);
                    // print(DescriptionName.text);
                    // print(
                    //     "Title Name ${titleName.text}, Description ${DescriptionName.text}");
                    // Map userRequiredData = {
                    //   "title_name": titleName.text,
                    //   "description": DescriptionName.text
                    // };
                  } else {
                    print("Please enter the title");
                  }
                  //////////////////////////////////////////////////////
                  // FirebaseFirestore.collection('collectionName').doc('documentName').set(formDetails);
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
      ),
    );

    // Add TextFormFields and ElevatedButton here.
  }
}
