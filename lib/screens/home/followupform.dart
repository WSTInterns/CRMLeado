import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyStepperForm extends StatefulWidget {
  MyStepperForm({Key? key, required this.email}) : super(key: key);
  String email;
  @override
  State<MyStepperForm> createState() => _MyStepperFormState();
}

class _MyStepperFormState extends State<MyStepperForm> {
  String? activity, notes;
  DateTime? selecteddate;
  TimeOfDay? selectedtime;
  var formkey = GlobalKey<FormState>();
  TextEditingController dateInputController = TextEditingController();
  final TextEditingController _controller = new TextEditingController();
  var items = ['Phone Call', 'Message', 'Meet', 'Note'];
  final timeController = TextEditingController();
  late String _selectedItem = '';
  final List<String> _items = ['Phone Call', 'Message', 'Meet', 'Note'];
  Map<String, dynamic> formDetails = {};

  void initState() {
    super.initState();
    _selectedItem = '_items[0]';
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    timeController.dispose();
    super.dispose();
  }

  addActivity() {
    var now = DateTime.now;
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var salesmail = FirebaseAuth.instance.currentUser!.email;
    var mail = widget.email;
    var toutc = DateTime(selecteddate!.year, selecteddate!.month,
        selecteddate!.day, selectedtime!.hour, selectedtime!.minute);
    var status = false;
    var act = activity;
    var note = notes;
    var eventstatus = 'upcoming';
    getStatus(toutc);
    String id = mail + salesmail! + toutc.toString() + activity.toString();
    DocumentReference document =
        FirebaseFirestore.instance.collection("Activities").doc(id);
    Map<String, dynamic> data = {
      "Date": toutc,
      "LeadUid": mail,
      "Salesuid": uid,
      "Status": false,
      "Type": activity,
      "description": note,
      "event_status": getStatus(toutc),
      // "created": now
    };
    print(data);
    document.set(data);

    // Calculate the notification time (1 hour before toutc)
    var notificationTime = toutc.subtract(Duration(hours: 1));

    // Schedule the notification
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: android);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    var androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.high,
      priority: Priority.high,
    );
    var platformDetails = NotificationDetails(android: androidDetails);
    flutterLocalNotificationsPlugin.schedule(
        0, // notification id
        'Reminder', // notification title
        'Your activity is coming up in 1 hour', // notification body
        notificationTime, // notification time
        platformDetails);

    Navigator.pop(context);

    Map<String, dynamic> list = {
      "year": toutc.year,
      "month": toutc.month,
      "date": toutc.day,
      "hour": toutc.hour,
      "minute": toutc.minute,
      "message": note
    };
    print("object");
    FirebaseFirestore.instance
        .collection('notify')
        .doc(widget.email)
        .set(list)
        .whenComplete(() => printInfo());
  }

  String getStatus(toutc) {
    int diffDays = toutc.difference(DateTime.now()).inDays;
    if (diffDays > -1 && diffDays < 7) {
      return 'upcoming';
    } else if (diffDays < 0) {
      return 'overdue';
    } else {
      return 'someday';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "ADD ACTIVITY",
            style: TextStyle(color: Colors.black),
          ),
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 35.5,
            ),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(left: 17, bottom: 0, right: 15, top: 0),
                    child: Text(
                      "ADD ACTIVITY",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: DropdownButtonFormField<String>(
                      validator: (value) {
                        if (_selectedItem == null) {
                          return 'REQUIRED';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2.5, color: Color(0xffD9ACF5)),
                        ),
                        hintText: 'Select an Acticity',
                      ),
                      items: <String>['Phone Call', 'Message', 'Meet', 'Note']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          onTap: () {
                            this.activity = value;
                          },
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        activity = newValue?.trim();
                      },
                    ),
                  ),
                  // new Expanded(

                  const SizedBox(
                    height: 23,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 17, bottom: 0, right: 15, top: 0),
                    child: Text(
                      "DATE",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    child: TextFormField(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Required";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Date',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2.5, color: Color(0xffD9ACF5)),
                        ),
                      ),
                      controller: dateInputController,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950, 1, 1),
                            lastDate: DateTime(2090, 1, 1));

                        if (pickedDate != null) {
                          final formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          dateInputController.text = formattedDate;
                          selecteddate = pickedDate;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 17, bottom: 0, right: 15, top: 0),
                    child: Text(
                      "TIME",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 15),
                      child: Center(
                          child: TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        },
                        readOnly: true,
                        controller: timeController,
                        decoration: InputDecoration(
                          hintText: 'Pick your Time',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.5, color: Color(0xffD9ACF5)),
                          ),
                        ),
                        onTap: () async {
                          var time = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());

                          if (time != null) {
                            timeController.text = time.format(context);
                            selectedtime = time;
                          }
                        },
                      ))),
                  const SizedBox(
                    height: 23,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 17, bottom: 0, right: 15, top: 0),
                    child: Text(
                      "NOTES",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                      onChanged: (value) {
                        this.notes = value;
                      },
                      maxLength: 500,
                      expands: false,

                      // minLines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        } else {
                          return null;
                        }
                      },
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2.5, color: Color(0xffD9ACF5)),
                        ),
                        // hintText: "Enter A Message Here",
                        hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: InkWell(
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          addActivity();
                        }
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xff4B56D2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                            child: Text(
                          "DONE",
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
            ),
          ),
        ));
  }
}
