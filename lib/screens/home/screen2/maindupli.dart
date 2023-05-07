import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'followup3.dart';
import 'overdue.dart';
import 'someday.dart';
import 'upcoming.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEFEFEF),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Container(
              child: Center(
                child: Text(
                  "Follow Ups",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black54,
          onTap: onTap,
          currentIndex: currentIndex,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          items: [
            BottomNavigationBarItem(
                label: "Clients", icon: Icon(Icons.apps)), //clients
            BottomNavigationBarItem(
                label: "Contents", icon: Icon(Icons.bar_chart)), //content
            BottomNavigationBarItem(
                label: "Follow Ups",
                icon: Icon(Icons.follow_the_signs)), //follow
            BottomNavigationBarItem(
                label: "More", icon: Icon(Icons.more)), //more
          ]),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              height: 5,
              color: Colors.grey,
            ),
          ),
          InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => overdue()),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Icon(
                          Icons.calendar_today,
                          color: Colors.red,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          "OVERDUE",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              )),
          Divider(),
          InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => upcoming()),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          "UPCOMING",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              )),
          Divider(),
          InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => someday()),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Icon(
                          Icons.calendar_today,
                          color: Colors.blueGrey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          "SOMEDAY",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blueGrey,
                      )
                    ],
                  ),
                ),
              )),
          Container(
            height: 5,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Icon(
                      Icons.calendar_today,
                      color: Color.fromARGB(255, 32, 129, 174),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      "TODAY",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 32, 129, 174),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              // Get.to(() => clientProf());
            },
            child: Padding(
              padding: EdgeInsets.all(2),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  child: Icon(
                    Icons.person,
                    size: 15,
                  ),
                ),
                title: Text("Privyr Support"),
                subtitle: Row(
                  children: [
                    Text("Due today"),
                    Spacer(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  /*
      backgroundColor: Colors.grey[100],
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.blue[50],
              child: ListTile(
                leading: const Icon(Icons.add),
                title: const Text(
                  'GFG title',
                  textScaleFactor: 1.5,
                ),
                trailing: const Icon(Icons.done),
                subtitle: const Text('This is subtitle'),
                selected: true,
                onTap: () {
                  setState(() {
                    txt = 'List Tile pressed';
                  });
                },
              ),
            ),
          ),
          Text(
            txt,
            textScaleFactor: 2,
          )
        ],
      ),
   */

  DateTime? _chosenDateTime;

// Show the modal that contains the CupertinoDatePicker
  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 350,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (val) {
                          // setState(() {
                          // _chosenDateTime = val;
                          //});
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: const Text('Done'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: const Text("Schedule follow up for Client"),
            )
          ],
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            /// This parameter indicates the action would be a default
            /// defualt behavior, turns the action's text to bold text.

            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Text(
                  "   Today",
                  style: TextStyle(
                      color: Color.fromARGB(255, 110, 109, 109), fontSize: 15),
                )
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Text(
                  "   Tomorrow",
                  style: TextStyle(
                      color: Color.fromARGB(255, 110, 109, 109), fontSize: 15),
                )
              ],
            ),
          ),
          CupertinoActionSheetAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as delete or exit and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Text(
                  "   3 days from now",
                  style: TextStyle(
                      color: Color.fromARGB(255, 110, 109, 109), fontSize: 15),
                )
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Text(
                  "   1 week from now",
                  style: TextStyle(
                      color: Color.fromARGB(255, 110, 109, 109), fontSize: 15),
                )
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Text(
                  "   1 month from now",
                  style: TextStyle(
                      color: Color.fromARGB(255, 110, 109, 109), fontSize: 15),
                )
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () => _showDatePicker(context),
            child: Row(
              children: [
                Text(
                  "   Select custom date and time",
                  style: TextStyle(
                      color: Color.fromARGB(255, 110, 109, 109), fontSize: 15),
                )
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Text(
                  "   Someday",
                  style: TextStyle(
                      color: Color.fromARGB(255, 110, 109, 109), fontSize: 15),
                )
              ],
            ),
          ),
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Text(
                  "   Never",
                  style: TextStyle(
                      color: Color.fromARGB(255, 110, 109, 109), fontSize: 15),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
