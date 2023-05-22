import 'package:brew_crew/screens/home/followUpForm.dart';
import 'package:brew_crew/screens/home/followUp_notes.dart';
import 'package:brew_crew/screens/home/phonecall.dart';
import 'package:brew_crew/stepper%20(1).dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';

class ClientProf extends StatefulWidget {
  const ClientProf(
      {super.key,
      required this.name,
      required this.email,
      required this.phoneNo});
  final String name, email;
  final int phoneNo;

  @override
  State<ClientProf> createState() => _ClientProfState();
}

// class _ClientProfState extends State<ClientProf> {
//   @override
//   Widget build(BuildContext context) {
//     return StepperWithStreamBuilder();
//   }
// }
class _ClientProfState extends State<ClientProf> {
  String? createdAt;
  Map<String, IconData> iconlist = {
    "Message": FaIcon(FontAwesomeIcons.whatsapp).icon!,
    "Phone Call": Icons.phone,
    "Meet": Icons.people_alt_outlined,
    "Note": Icons.note_alt_rounded
  };
   

  Future<String>? notesFuture;
  deleteActivity(docid) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Activities").doc(docid);
    documentReference.delete();
  }
  void deleteClient(){
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Activities").doc(widget.email);
        documentReference.delete();
  }

  void _callFunctionality(int phoneNo) async {
    final Uri phoneNumber = Uri(scheme: 'tel', path: '$phoneNo');
    try {
      if (await canLaunchUrl(phoneNumber)) {
        await launchUrl(phoneNumber);
      } else {
        throw FormatException('Could not call $phoneNumber');
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open Phone app due to some error!!')),
      );
      print(e.toString());
    }
  }

  void _mailfunctionalty(String email) async {
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (BuildContext context) =>
    //         SendMessage(phoneNo: widget.phoneNo, email: widget.email)));

    final Uri emailUri =
        Uri(scheme: 'mailto', path: '$email', query: 'subject= email&body=');
    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        throw FormatException('Could not mail $emailUri');
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open mail due to some error!!')),
      );
      print(e.toString());
    }
  }

  void _whatsappfunctionality(int phoneNo) async {
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (BuildContext context) =>
    //         SendMessage(phoneNo: widget.phoneNo, email: widget.email)));
    String phoneNumber = "$phoneNo";
    String message = "";
    String urlMessage = Uri.encodeFull(message);
    Uri uri = Uri.parse("whatsapp://send?phone=$phoneNumber&text=$urlMessage");
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not connect to $phoneNumber';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open WhatsApp due to some error!!')),
      );
      print(e.toString());
    }
  }
  TextEditingController tec = TextEditingController();

  Future<String> getNotes() async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('Leads').doc(widget.email);

    DocumentSnapshot documentSnapshot = await docRef.get();
    if (documentSnapshot.exists) {
      return documentSnapshot.get('notes') as String? ?? '';
    }
    return '';
  }

  getFollowup() {}

  @override
  void initState() {
    super.initState();
    notesFuture = getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          '',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Montserrat",
            fontSize: 17,
          ),
        ),
        // leading: const Icon(
        //   Icons.arrow_back_ios,
        //   color: Colors.black,
        // ),

        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              bottomsheet(
                context,
                widget.email,
              );
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
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(50, 50, 93, 0.25)
                          .withOpacity(0.08),
                      // color: const Color.fromRGBO(0, 0, 0, 0.3).withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 20,
                      offset: const Offset(0, 8), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 15, 30),
                    child: Text(
                      "${widget.name}".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(left: 5.0, right: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xff4B56D2),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromRGBO(50, 50, 93, 0.25)
                                  .withOpacity(0.4),
                              // color: const Color.fromRGBO(0, 0, 0, 0.3).withOpacity(0.1),
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            _callFunctionality(widget.phoneNo);
                          },
                          // foregroundColor: Colors.white,

                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(left: 5.0, right: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xff4B56D2),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromRGBO(50, 50, 93, 0.25)
                                  .withOpacity(0.4),
                              // color: const Color.fromRGBO(0, 0, 0, 0.3).withOpacity(0.1),
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            _mailfunctionalty(widget.email);
                          },
                          // foregroundColor: Colors.white,

                          child: Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(left: 5.0, right: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xff4B56D2),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromRGBO(50, 50, 93, 0.25)
                                  .withOpacity(0.4),
                              // color: const Color.fromRGBO(0, 0, 0, 0.3).withOpacity(0.1),
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            _whatsappfunctionality(widget.phoneNo);
                          },
                          // foregroundColor: Colors.white,

                          child: Icon(
                            FaIcon(FontAwesomeIcons.whatsapp).icon,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => SendMessage(
                          phoneNo: widget.phoneNo, email: widget.email)));
                },
                child: Container(
                  width: double.infinity,
                  height: 80,
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromRGBO(50, 50, 93, 0.25)
                            .withOpacity(0.08),
                        // color: const Color.fromRGBO(0, 0, 0, 0.3).withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset:
                            const Offset(0, 8), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ListTile(
            title: FutureBuilder<String>(
              future: notesFuture,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  String notes = snapshot.data ?? '';
                  return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      '${notes}',
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
    ),
    SizedBox(height: 4), // Adjust the spacing between main text and subtitle
    Row(
      children: [
        Text(
          'Notes',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ],
)
;
                }
              },
            ),
          ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => SendMessage(
                          phoneNo: widget.phoneNo, email: widget.email)));
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromRGBO(50, 50, 93, 0.25)
                            .withOpacity(0.08),
                        // color: const Color.fromRGBO(0, 0, 0, 0.3).withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset:
                            const Offset(0, 8), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text(
                    'QUICK RESPONSE',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  print(FirebaseAuth.instance.currentUser!.uid);
                  var notes = getNotes();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => FollowUpNotes(
                            name: widget.name,
                            email: widget.email,
                            phoneNo: widget.phoneNo,
                            // notes: notes,
                          )));
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromRGBO(50, 50, 93, 0.25)
                            .withOpacity(0.08),
                        // color: const Color.fromRGBO(0, 0, 0, 0.3).withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset:
                            const Offset(0, 8), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text(
                    "NOTES",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MyStepperForm(email: widget.email
                              // notes: notes,
                              )));
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromRGBO(50, 50, 93, 0.25)
                            .withOpacity(0.08),
                        // color: const Color.fromRGBO(0, 0, 0, 0.3).withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset:
                            const Offset(0, 8), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text(
                    "ADD ACTIVITY",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 45,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(50, 50, 93, 0.25)
                          .withOpacity(0.08),
                      // color: const Color.fromRGBO(0, 0, 0, 0.3).withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 20,
                      offset: const Offset(0, 8), // changes position of shadow
                    ),
                  ],
                ),
                child: Text(
                  "TIMELINE",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat"),
                ),
              ),
              Divider(
                height: 1,
              ),
              StreamBuilder<QuerySnapshot>(
                
                stream: FirebaseFirestore.instance
                    .collection("Activities")
                    .where('LeadUid', isEqualTo: widget.email)
                    .snapshots(),
                builder: ((context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, int index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                        Timestamp timestamp = documentSnapshot.get('Date');
                        DateTime dateTime = timestamp.toDate();
                        String formattedDate =
                            DateFormat('d MMMM h:mm a').format(dateTime);

                        // var clientName = documentSnapshot["name"];
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            height: 80,
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.only(
                              //   bottomLeft: Radius.circular(10),
                              //   bottomRight: Radius.circular(10),
                              // ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromRGBO(50, 50, 93, 0.25)
                                      .withOpacity(0.08),
                                  // color: const Color.fromRGBO(0, 0, 0, 0.3).withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 20,
                                  offset: const Offset(
                                      0, 8), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: Icon(
                                iconlist["${documentSnapshot["Type"]}"],
                                color: Color(0xff4B56D2),
                                size: 30,
                              ),
                              trailing: IconButton(
                                  icon: const Icon(Icons.delete_forever),
                                  color: Color.fromARGB(255, 207, 117, 117),
                                  onPressed: () {
                                    // deleteActivity(documentSnapshot.id);
                                    
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          CupertinoAlertDialog(
                                        content: const Text(
                                          'Are you sure you want to delete this activity?',
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                          ),
                                        ),
                                        actions: [
                                          CupertinoDialogAction(
                                            child: const Text(
                                              'Yes',
                                              style: TextStyle(
                                                  color:
                                                      const Color(0Xff4B56D2)),
                                            ),
                                            onPressed: () {
                                              deleteActivity(
                                                  documentSnapshot.id);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          CupertinoDialogAction(
                                            child: const Text('No',
                                                style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    color: const Color(
                                                        0Xff4B56D2))),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                              title: Text("${formattedDate}"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "${documentSnapshot['Type']}",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text("${documentSnapshot['description']}"),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getDay(DateTime target) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final dbyesterday = DateTime(now.year, now.month, now.day - 2);
  final tdbefore = DateTime(now.year, now.month, now.day - 3);
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final tomorrow = DateTime(now.year, now.month, now.day + 1);
  final datomorrow = DateTime(now.year, now.month, now.day + 2);
  final tdafter = DateTime(now.year, now.month, now.day + 3);
  if (target == now) {
    target = now;
    return "Just Now";
  } else if (target == today) {
    target = today;
    return "Today";
  } else if (target == tomorrow) {
    target = tomorrow;
    return "Tommorow";
  } else if (target == datomorrow) {
    target = datomorrow;
    return "Day After Tommorow";
  } else if (target == dbyesterday) {
    target = dbyesterday;
    return "Day Before Yesterday";
  } else if (target == tdafter) {
    target = tdafter;
    return "After 3 days";
  } else if (target == tdbefore) {
    target = tdbefore;
    return "3 days before";
  }

  String formattedDate = DateFormat('d MMMM h:mm a').format(target);
  return formattedDate;
}

void bottomsheet(BuildContext context,String email) {
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
                onTap: () {
                 
                },
                child: ListTile(
                  onTap: () {
                    DocumentReference documentReference =
                    FirebaseFirestore.instance.collection("Leads").doc(email);
                    documentReference.delete();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  dense: true,
                  title: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        size: 26,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Delete Client',
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
