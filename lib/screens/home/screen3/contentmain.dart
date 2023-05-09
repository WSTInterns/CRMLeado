import 'package:brew_crew/screens/home/screen3/message_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'files.dart';
import 'pages.dart';

import 'newmessage_template.dart';

class MyAppAk extends StatefulWidget {
  MyAppAk({super.key});
  @override
  State<MyAppAk> createState() => _MyAppAkState();
}
// =======
//       title: 'Flutter Demo',
//       home: MyWidget(),
//     );
//   }
// }
// >>>>>>> Stashed changes

class _MyAppAkState extends State<MyAppAk> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(_switchTabIndex);
  }

  void _switchTabIndex() {
    print(_tabController.index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          floatingActionButton: _tabController.index == 0
              ? FloatingActionButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewTemplate())),
                  // onPressed: () => Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => NewTemplate())),
                  backgroundColor: Color(0xff4B56D2),
                  child: Icon(Icons.add),
                )
              : null,

          // floatingActionButton: FloatingActionButton(
          //     foregroundColor: Colors.black,
          //     child: Icon(Icons.add),
          //     onPressed: () {
          //       Navigator.of(context).pushReplacement(MaterialPageRoute(
          //           builder: (BuildContext context) => NewTemplate()));
          //     }),
          backgroundColor: Colors.grey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xff4B56D2),
            // title: Container(
            //   //alignment: Alignment.topLeft,
            //   width: double.infinity,
            //   height: 40,
            //   color: Colors.white,
            //   child: const Center(
            //     child: TextField(
            //       decoration: InputDecoration(
            //         border: InputBorder.none,
            //         hintText: 'Search for something',
            //         hintStyle: TextStyle(
            //           fontFamily: "Montserrat",
            //         ),
            //         prefixIcon: Icon(
            //           Icons.search,
            //           color: Color(0xff4B56D2),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            centerTitle: true,
            title: TabBar(
              labelColor: Colors.white, //<-- selected text color
              unselectedLabelColor: Colors.white,
              indicatorColor: Colors.white, //<-- Unselected text color
              controller: _tabController,
              tabs: const [
                Tab(
                  child: Text(
                    'Messages',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    'Files',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    'Media',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Center(
                child: templates(),
              ),
              Center(
                child: contentFilesScreen(),
              ),
              Center(child: pages())
            ],
            // children: <Widget>[
            //   Center(child: templates()),
            //   Center(
            //     child: Files(),
            //   )
            // ],
          ),
        ));
  }
}

class templates extends StatefulWidget {
  @override
  State<templates> createState() => _templatesState();
}

class _templatesState extends State<templates>
    with SingleTickerProviderStateMixin {
  // String? title, message;
  String convertNewLine(String content) {
    print("Converting");
    return content.replaceAll(r'\n', '\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),

            Container(
              // padding: EdgeInsets.symmetric(horizontal: 7),
              // transform: Matrix4.translationValues(0.0, -30.0, 0.0),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("message")
                    .where('uid',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: ((context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, int index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                        var title = documentSnapshot["title"];
                        var message = documentSnapshot["message"];
                        return SingleChildScrollView(
                          child: IntrinsicHeight(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MessageContentPage(
                                          message: message,
                                          title: title,
                                        )));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 10,
                                  right: 15,
                                  left: 15,
                                ),
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      // color: const Color.fromRGBO(
                                      //         0, 0, 0, 0)
                                      //     .withOpacity(0.04),
                                      color:
                                          const Color.fromRGBO(50, 50, 93, 0.25)
                                              .withOpacity(0.08),
                                      // color:
                                      //     const Color.fromRGBO(50, 50, 93, 0.25).withOpacity(0.1),
                                      spreadRadius: 10,
                                      blurRadius: 20,
                                      offset: const Offset(
                                          0, 8), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.message_outlined,
                                      size: 27,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        title.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
              ),
            ),

            // Container(
            //   child: Text('Title:' + title.toString()),
            // )
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}



// final actionSheet = CupertinoActionSheet(
//     title: Text(
//       'Sort content by',
//       style: TextStyle(fontSize: 20),
//     ),
//     actions: <Widget>[
//       CupertinoActionSheetAction(
//         onPressed: () {},
//         child: Text(
//           "Message Title(A-Z)",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       CupertinoActionSheetAction(
//           onPressed: () {},
//           child: Text(
//             'Message Title(Z-A)',
//             style: TextStyle(color: Colors.black),
//           )),
//       CupertinoActionSheetAction(
//           onPressed: () {},
//           child: Text(
//             'Most Recently Used',
//             style: TextStyle(color: Colors.black),
//           )),
//       CupertinoActionSheetAction(
//           onPressed: () {},
//           child: Text(
//             'Data Created (Newest First)',
//             style: TextStyle(color: Colors.black),
//           )),
//       CupertinoActionSheetAction(
//           onPressed: () {},
//           child: Text(
//             'Data Created (Newest First)',
//             style: TextStyle(color: Colors.black),
//           )),
//     ]);
