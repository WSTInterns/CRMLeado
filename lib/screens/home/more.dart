import 'package:brew_crew/screens/authenticate/login.dart';
import 'package:brew_crew/screens/home/convertedsaleslist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/cupertino.dart';
import '../../services/auth.dart';
import '../authenticate/handler.dart';

class Moree extends StatefulWidget {
  Moree({super.key});

  @override
  State<Moree> createState() => _MoreeState();
}

class _MoreeState extends State<Moree> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [],
          title: const Center(
            child: Text(
              "ADDITIONAL OPTIONS",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat",
                // fontSize: 22,
              ),
            ),
          ),
          backgroundColor: Color(0xff4B56D2),
          elevation: 0,
        ),
        body: _taskList(context),
      ),
    );
  }

  @override
  signOut() async {
    await _auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Handler()));
  }

  Widget _taskList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 70,
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
              child: Padding(
                padding: EdgeInsets.fromLTRB(18, 0, 15, 0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => convertedsales()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.bar_chart,
                        size: 38,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        "SALES",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          color: Colors.black,
                          tooltip: 'Go back',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => convertedsales()));
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 13,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(50, 50, 93, 0.25)
                        .withOpacity(0.08),
                    // color: const Color.fromRGBO(0, 0, 0, 0.3).withOpacity(0.1),
                    spreadRadius: 10,
                    blurRadius: 20,
                    offset: const Offset(0, 8), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(18, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.assignment,
                      size: 38,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      "REPORTS",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios),
                    // IconButton(
                    //     icon: const Icon(Icons.arrow_forward_ios),
                    //     color: Colors.black,
                    //     tooltip: 'Go back',
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => convertedsales()));
                    //     }),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 13,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(50, 50, 93, 0.25)
                        .withOpacity(0.08),
                    // color: const Color.fromRGBO(0, 0, 0, 0.3).withOpacity(0.1),
                    spreadRadius: 10,
                    blurRadius: 20,
                    offset: const Offset(0, 8), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(18, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.attach_money,
                      size: 38,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      "INCENTIVES",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios),
                    // IconButton(
                    //     icon: const Icon(Icons.arrow_forward_ios),
                    //     color: Colors.black,
                    //     tooltip: 'Go back',
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => convertedsales()));
                    //     }),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 13,
          ),
          InkWell(
            onTap: () {
              // signOut();
              showDialog(
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                  content: const Text(
                    'Are you sure you want to logout?',
                    style: TextStyle(
                      fontFamily: "Montserrat",
                    ),
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: const Color(0Xff4B56D2)),
                      ),
                      onPressed: () {
                        signOut();
                        Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => Handler()),
  (Route<dynamic> route) => false, // Remove all routes in the stack
);
                        
                      },
                    ),
                    CupertinoDialogAction(
                      child: const Text('No',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              color: const Color(0Xff4B56D2))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(50, 50, 93, 0.25)
                        .withOpacity(0.08),
                    // color: const Color.fromRGBO(0, 0, 0, 0.3).withOpacity(0.1),
                    spreadRadius: 10,
                    blurRadius: 20,
                    offset: const Offset(0, 8), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(18, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.logout,
                      size: 38,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      "LOGOUT",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios),
                    // IconButton(
                    //     icon: const Icon(Icons.arrow_forward_ios),
                    //     color: Colors.black,
                    //     tooltip: 'Go back',
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => convertedsales()));
                    //     }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // ListTile(
      //         leading: Icon(Icons.verified_user_rounded),
      //         title: Text("Accounts"),
      //         //subtitle: const Text('Number'),
      //         trailing: IconButton(
      //         icon: const ,
      //         color: Colors.black,
      //         tooltip: 'Show Snackbar',
      //         onPressed: () {})),
      //   ListTile(
      //         leading: Icon(Icons.bar_chart),
      //         title: Text("Sales"),
      //         //subtitle: const Text('Number'),
      //         trailing: IconButton(
      //         icon: const Icon(Icons.arrow_forward_ios),
      //         color: Colors.black,
      //         tooltip: 'Show Snackbar',
      //         onPressed: () {})),
    );
  }
}
  
// /*
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class Moree extends StatelessWidget {
//   const Moree({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         length: 3,
//         child: Scaffold(

//           appBar: AppBar(
//             title: Container(
//               //alignment: Alignment.topLeft,
//               width: double.infinity,
//               height: 40,
//               color: Colors.white,
//               child: const Center(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search for something',
//                     prefixIcon: Icon(Icons.search),
//                   ),
//                 ),
//               ),
//             ),
//             centerTitle: true,
//             bottom: TabBar(
//               tabs: [
//                 Tab(
//                   text: 'All Clients',
//                 ),
//                 Tab(
//                   text: 'Team',
//                 ),
//                 Tab(
//                   text: 'Groups',
//                 ),
//               ],
//             ),
//           ),
//           body: TabBarView(
//             children: [
//               Center(
//                 child: Text('Chats Page'),
//               ),
//               Center(
//                 child: Text('Status Page'),
//               ),
//               Center(
//                 child: Text('Calls Page'),
//               ),
              
//             ],
//           ),
//         ));
//   }

// }
// */