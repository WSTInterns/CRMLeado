// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class clientProf extends StatelessWidget {
//   final String name;
//   const clientProf(
//       { Key? key,
//       required this.name,
//       })
//       : super(key: key);


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('data'),
//       ),
//       body: Placeholder(),
//     );
//   }
// }

// import 'dart:developer';

// import 'package:another_stepper/another_stepper.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'Phonecalls.dart';
// import 'controllers/followupController.dart';
// import 'followmain.dart';
// import 'package:flutter/cupertino.dart';
// import 'meeting.dart';
// import 'messages.dart';
// import 'notes.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class clientProf extends StatefulWidget {
//   const clientProf({super.key});

//   @override
//   State<clientProf> createState() => _clientProf();
// }

// class _clientProf extends State<clientProf> {
//   final FollowupController followupController = Get.put(FollowupController());

//   TextEditingController note = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   Get.put(FollowupController());
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffEFEFEF),
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Colors.white,
//         title: IconButton(
//             onPressed: () {
//               // Navigator.pushReplacement(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => const MyAppSak()),
//               // );
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back_ios,
//               color: Colors.black,
//             )),
//         actions: <Widget>[
//           Padding(
//             padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
//             child: Text(
//               "Options   ",
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.topCenter,
//           ),
//         ],
//         automaticallyImplyLeading: false,
//       ),
//       body: Column(
//         children: [
//           Container(
//             color: Colors.white,
//             height: 70,
//             child: Padding(
//                 padding: EdgeInsets.all(10),
//                 child: Row(
//                   children: [
//                     Container(
//                       height: 80,
//                       child: Text(
//                         "Privyr Support",
//                         style: TextStyle(
//                             fontSize: 30,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black),
//                         textAlign: TextAlign.left,
//                       ),
//                     ),
//                   ],
//                 )),
//           ),

//           Container(
//             color: Colors.white,
//             child: Row(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(10),
//                   child: FloatingActionButton(
//                     onPressed: null,
//                     foregroundColor: Colors.white,
//                     backgroundColor: Color(0xff4B56D2),
//                     child: Icon(Icons.call),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(10),
//                   child: FloatingActionButton(
//                     onPressed: null,
//                     foregroundColor: Colors.white,
//                     backgroundColor: Color(0xff4B56D2),
//                     child: Icon(Icons.sms),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(10),
//                   child: FloatingActionButton(
//                     onPressed: null,
//                     foregroundColor: Colors.white,
//                     backgroundColor: Color(0xff4B56D2),
//                     child: Icon(Icons.mail),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(10),
//                   child: FloatingActionButton(
//                     onPressed: null,
//                     foregroundColor: Colors.white,
//                     backgroundColor: Color(0xff4B56D2),
//                     child: Icon(
//                       Icons.perm_phone_msg,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           Padding(
//             padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//             child: InkWell(
//               onTap: () {},
//               child: Container(
//                 color: Colors.white,
//                 height: 50,
//                 child: InkWell(
//                   onTap: () => _showActionSheet(context),
//                   child: Column(
//                     // mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: 25,
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                               child: InkWell(
//                                 onTap: () {},
//                                 child: Container(
//                                   child: Row(
//                                     children: [
//                                       Text(
//                                         "Follow Up ",
//                                         style: TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black),
//                                       ),
//                                       Obx(
//                                         () => Text(
//                                           followupController
//                                                   .dateTime.value.isEmpty
//                                               ? " "
//                                               : followupController
//                                                   .dateTime.value,
//                                           style: TextStyle(
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.black),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                         child: Obx(
//                           () => Text(
//                             followupController.dateTime.value.isEmpty
//                                 ? "No follow ups"
//                                 : followupController.dateTime.value,
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.grey),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           /*Padding(
//               padding: EdgeInsets.all(10),
//               child: InkWell(
//                 onTap: () => _showActionSheet(context),
//                 child: Container(
//                     height: 30,
//                     child: Column(
//                       children: [Container(child: Column(),)
//                         Text(
//                           "Follow Up",
//                           style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black),
//                         )
//                       ],
//                     )),
//               ),
//             ),*/

//           Container(
//             color: Colors.white,
//             height: 50,
//             child: InkWell(
//               onTap: () {},
//               child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   InkWell(
//                     onTap: () => _bottomsheet(context),
//                     child: Container(
//                       height: 30,
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
//                             child: InkWell(
//                               onTap: () => _bottomsheet(context),
//                               child: Container(
//                                 child: Text(
//                                   "NOTES",
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
//                     /*child: Text(
//                       "Add something here...",
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.normal,
//                           color: Colors.grey),
//                     ),*/
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             color: Color(0xffEFEFEF),
//             height: 5,
//           ),
//           Container(
//             height: 50,
//             color: Colors.white,
//             child: Padding(
//                 padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
//                 child: Row(
//                   children: [
//                     Text(
//                       "TIMELINE",
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     )
//                   ],
//                 )),
//           ),

//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             color: Colors.white,
//             // height: 50,
//             child: Expanded(
//               child: StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection('Follow-ups')
//                     .doc('1')
//                     .snapshots(),
//                 builder: ((context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   final data = snapshot.data?.data() ?? {};
//                   return AnotherStepper(
//                     stepperList: [
//                       StepperData(
//                         title: StepperText(
//                           "Add Activity",
//                           textStyle: const TextStyle(
//                             color: Colors.grey,
//                           ),
//                         ),
//                         iconWidget: InkWell(
//                           onTap: () => _showAction(context),
//                           child: Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: const BoxDecoration(
//                                 color: Colors.green,
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(30))),
//                             child: const Icon(
//                               Icons.add_circle_outline_rounded,
//                             ),
//                           ),
//                         ),
//                       ),
//                       for (var i = 0; i < 3; i++)
//                         // for (var i = 0; i < data['xxx'].length; i++)
//                         StepperData(
//                           title: StepperText(
//                             "Order Placed",
//                             textStyle: const TextStyle(
//                               color: Colors.grey,
//                             ),
//                           ),
//                           subtitle: StepperText("Your order has been placed"),
//                           iconWidget: Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: const BoxDecoration(
//                                 color: Colors.green,
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(30))),
//                             child: const Icon(Icons.looks_one,
//                                 color: Colors.white),
//                           ),
//                         ),
//                     ],
//                     stepperDirection: Axis.vertical,
//                     iconWidth:
//                         40, // Height that will be applied to all the stepper icons
//                     iconHeight:
//                         40, // Width that will be applied to all the stepper icons
//                     verticalGap: 20,
//                   );
//                 }),
//               ),
//             ),
//           ),

//           //ScreenProgress(ticks: 2)
//           Expanded(
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: InkWell(
//                 onTap: () {
//                   //Get.to(() => StepperPage());
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.fromLTRB(10, 18, 10, 20),
//                   height: 60,
//                   decoration: const BoxDecoration(
//                     color: Color(0xff4B56D2),
//                   ),
//                   child: const Center(
//                     child: Text(
//                       "QUICK RESPONSE",
//                       style: TextStyle(
//                         color: Color(0xffECF2FF),
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _bottomsheet(BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (contxt) {
//           return Container(
//             height: 2500,
//             color: Color(0xFF737373),
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Theme.of(context).canvasColor,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30),
//                       topRight: Radius.circular(30))),
//               height: 500,
//               child: Column(
//                 children: [
//                   ListTile(
//                     leading: Icon(Icons.edit),
//                     title: Text('Notes'),
//                     // onTap: () {
//                     //   // Navigator.pop(context);
//                     //   pickImage(ImageSource.gallery);
//                     // },
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: TextField(
//                       maxLines: null,
//                       decoration: InputDecoration.collapsed(
//                           hintText: "Add something here"),
//                     ),
//                   ),
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.bottomCenter,
//                       child: InkWell(
//                         onTap: () => Navigator.of(context).pop(),
//                         child: Container(
//                           margin: const EdgeInsets.fromLTRB(10, 18, 10, 20),
//                           height: 60,
//                           decoration: const BoxDecoration(
//                             color: Color(0xff4B56D2),
//                           ),
//                           child: const Center(
//                             child: Text(
//                               "SAVE",
//                               style: TextStyle(
//                                 color: Color(0xffECF2FF),
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   void _showAction(BuildContext context) {
//     showCupertinoModalPopup<void>(
//       context: context,
//       builder: (BuildContext context) => CupertinoActionSheet(
//         title: Row(
//           children: [
//             Padding(
//               padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//               child: Text("Add Activity"),
//             )
//           ],
//         ),
//         actions: <CupertinoActionSheetAction>[
//           CupertinoActionSheetAction(
//             /// This parameter indicates the action would be a default
//             /// defualt behavior, turns the action's text to bold text.

//             onPressed: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => phonecalls()),
//               );
//             },
//             child: Row(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                   child: Icon(Icons.call),
//                 ),
//                 Text(
//                   "   Phone Call",
//                   style: TextStyle(color: Colors.black, fontSize: 15),
//                 )
//               ],
//             ),
//           ),
//           CupertinoActionSheetAction(
//             /// This parameter indicates the action would be a default
//             /// defualt behavior, turns the action's text to bold text.

//             onPressed: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => messages()),
//               );
//             },
//             child: Row(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                   child: Icon(Icons.wechat_sharp),
//                 ),
//                 Text(
//                   "   Message",
//                   style: TextStyle(color: Colors.black, fontSize: 15),
//                 )
//               ],
//             ),
//           ),
//           CupertinoActionSheetAction(
//             /// This parameter indicates the action would be a default
//             /// defualt behavior, turns the action's text to bold text.

//             onPressed: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => meetings()),
//               );
//             },
//             child: Row(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                   child: Icon(Icons.calendar_today),
//                 ),
//                 Text(
//                   "   Meeting",
//                   style: TextStyle(color: Colors.black, fontSize: 15),
//                 )
//               ],
//             ),
//           ),
//           CupertinoActionSheetAction(
//             /// This parameter indicates the action would be a default
//             /// defualt behavior, turns the action's text to bold text.

//             onPressed: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => notes()),
//               );
//             },
//             child: Row(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                   child: Icon(Icons.note_add_outlined),
//                 ),
//                 Text(
//                   "   Note",
//                   style: TextStyle(color: Colors.black, fontSize: 15),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     throw UnimplementedError();
//   }

//   DateTime? _chosenDateTime;

// // Show the modal that contains the CupertinoDatePicker
//   void _showDatePicker(ctx) {
//     // showCupertinoModalPopup is a built-in function of the cupertino library
//     showCupertinoModalPopup(
//         context: ctx,
//         builder: (_) => Container(
//               height: 350,
//               color: const Color.fromARGB(255, 255, 255, 255),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 250,
//                     child: CupertinoDatePicker(
//                         initialDateTime: DateTime.now(),
//                         onDateTimeChanged: (val) {
//                           //setState(() {
//                           //  _chosenDateTime = val;
//                           //});
//                         }),
//                   ),

//                   // Close the modal
//                   CupertinoButton(
//                     child: const Text('Done'),
//                     onPressed: () => Navigator.of(ctx).pop(),
//                   )
//                 ],
//               ),
//             ));
//   }

//   void _showActionSheet(BuildContext context) {
//     showCupertinoModalPopup<void>(
//       context: context,
//       builder: (BuildContext context) => CupertinoActionSheet(
//         title: Row(
//           children: [
//             Padding(
//               padding: EdgeInsets.fromLTRB(1, 0, 0, 0),
//               child: const Text("Schedule follow up for Client"),
//             )
//           ],
//         ),
//         actions: <CupertinoActionSheetAction>[
//           CupertinoActionSheetAction(
//             key: Key('xys'),

//             /// This parameter indicates the action would be a default
//             /// defualt behavior, turns the action's text to bold text.

//             onPressed: () {
//               followupController.dateTime.value = 'today';
//               Navigator.pop(context);
//             },
//             child: Row(
//               children: [
//                 Text(
//                   "   Today",
//                   style: TextStyle(
//                       color: Color.fromARGB(255, 110, 109, 109), fontSize: 15),
//                 )
//               ],
//             ),
//           ),
//           CupertinoActionSheetAction(
//             key: Key('today'),
//             onPressed: () {
//               followupController.dateTime.value = 'tomorrow';
//               Navigator.pop(context);
//             },
//             child: Row(
//               children: [
//                 Text(
//                   "   Tomorrow",
//                   style: TextStyle(
//                       color: Color.fromARGB(255, 110, 109, 109), fontSize: 15),
//                 )
//               ],
//             ),
//           ),
//           CupertinoActionSheetAction(
//             key: Key('tomorrow'),

//             /// This parameter indicates the action would perform
//             /// a destructive action such as delete or exit and turns
//             /// the action's text color to red.
//             isDestructiveAction: true,
//             onPressed: () {
//               followupController.dateTime.value = 'in 3 days from now';
//               Navigator.pop(context);
//             },
//             child: Row(
//               children: [
//                 Text(
//                   "   3 days from now",
//                   style: TextStyle(
//                       color: Color.fromARGB(255, 110, 109, 109), fontSize: 15),
//                 )
//               ],
//             ),
//           ),
//           CupertinoActionSheetAction(
//             key: Key('3 days from now'),
//             onPressed: () {
//               followupController.dateTime.value = 'in 1 week from now';
//               Navigator.pop(context);
//             },
//             child: Row(
//               children: [
//                 Text(
//                   "   1 week from now",
//                   style: TextStyle(
//                       color: Color.fromARGB(255, 110, 109, 109), fontSize: 15),
//                 )
//               ],
//             ),
//           ),
//           CupertinoActionSheetAction(
//             key: Key("1 week from now"),
//             onPressed: () {
//               followupController.dateTime.value = 'in 1 month from now';
//               Navigator.pop(context);
//             },
//             child: Row(
//               children: [
//                 Text(
//                   "   1 month from now",
//                   style: TextStyle(
//                       color: Color.fromARGB(255, 110, 109, 109), fontSize: 15),
//                 )
//               ],
//             ),
//           ),
//           CupertinoActionSheetAction(
//             key: Key('1 month'),
//             onPressed: () => _showDatePicker(context),
//             child: Row(
//               children: [
//                 Text(
//                   "   Select custom date and time",
//                   style: TextStyle(
//                       color: Color.fromARGB(255, 110, 109, 109), fontSize: 15),
//                 )
//               ],
//             ),
//           ),
//           CupertinoActionSheetAction(
//             key: Key('custom date'),
//             onPressed: () {
//               followupController.dateTime.value = ' in someday';
//               Navigator.pop(context);
//             },
//             child: Row(
//               children: [
//                 Text(
//                   "   Someday",
//                   style: TextStyle(
//                       color: Color.fromARGB(255, 110, 109, 109), fontSize: 15),
//                 )
//               ],
//             ),
//           ),
//           CupertinoActionSheetAction(
//             key: Key('someday'),
//             isDefaultAction: true,
//             onPressed: () {
//               followupController.dateTime.value = 'Never';
//               Navigator.pop(context);
//             },
//             child: Row(
//               children: [
//                 Text(
//                   "   Never",
//                   style: TextStyle(
//                       color: Color.fromARGB(255, 110, 109, 109), fontSize: 15),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
