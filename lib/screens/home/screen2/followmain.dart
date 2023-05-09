import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'followUp3.dart';
import 'overdue.dart';
import 'someday.dart';
import 'upcoming.dart';

// class MyAppSak extends StatelessWidget {
//   const MyAppSak({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//       ),
//       home: const MyAppSak(title: 'Flutter Demo Home Page'),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

class MyAppSak extends StatefulWidget {
  const MyAppSak({super.key});
  @override
  State<MyAppSak> createState() => _MyAppSak();
}

class _MyAppSak extends State<MyAppSak> {
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: const Color(0xff4B56D2),
        title: Column(
          children: [
            const Center(
              child: Text(
                "Follow Ups",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                      offset: const Offset(0, 8), // changes position of shadow
                    ),
                  ],
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: double.infinity,
                    minHeight: 50,
                  ),
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.calendar_today,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "OVERDUE",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const overdue()),
                );
              },
            ),

            // InkWell(
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => overdue()),
            //       );
            //     },
            //     child: Container(
            //       height: 50,

            //         padding: EdgeInsets.all(10),
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //           ),
            //           child: Row(
            //             children: [
            //               SizedBox(width: 10,),
            //               Icon(
            //                   Icons.calendar_today,
            //                   color: Colors.red,
            //                 ),
            //               SizedBox(width: 10,),
            //               Text(
            //                   "OVERDUE",
            //                   style: TextStyle(
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.bold,
            //                       color: Colors.red),
            //                 ),

            //               Spacer(),
            //               Icon(
            //                 Icons.arrow_forward_ios,
            //                 color: Colors.red,
            //               )
            //             ],
            //           ),

            //     )),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                      offset: const Offset(0, 8), // changes position of shadow
                    ),
                  ],
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: double.infinity,
                    minHeight: 50,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.calendar_today,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "UPCOMING",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                      )
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => upcoming()),
                );
              },
            ),

            // InkWell(
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => upcoming()),
            //       );
            //     },
            //     child: Container(
            //       height: 50,

            //         padding: EdgeInsets.all(10),
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //           ),
            //           child: Row(
            //             children: [
            //               SizedBox(width: 10,),
            //               Icon(
            //                   Icons.calendar_today,

            //                 ),
            //               SizedBox(width: 10,),
            //               Text(
            //                   "UPCOMING",
            //                   style: TextStyle(
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.bold,
            //                       ),
            //                 ),

            //               Spacer(),
            //               Icon(
            //                 Icons.arrow_forward_ios,

            //               )
            //             ],
            //           ),

            //     )),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                      offset: const Offset(0, 8), // changes position of shadow
                    ),
                  ],
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: double.infinity,
                    minHeight: 50,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.calendar_today,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "SOMEDAY",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blueGrey,
                      )
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => someday()),
                );
              },
            ),
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

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
}
