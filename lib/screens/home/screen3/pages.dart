//import 'package:brew_crew/screens/home/screen3/previedPage.dart';
import 'package:flutter/material.dart';
import 'product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class pages extends StatefulWidget {
  pages({super.key});
  // pages({Key? key}) : super(key: key) ;
  //   _stream = _reference.snapshots();

  //CollectionReference _reference =
  //    FirebaseFirestore.instance.collection('pages');
  late Stream<QuerySnapshot> _stream;

  @override
  State<pages> createState() => _pagesState();
}

class _pagesState extends State<pages> {
  //_stream = _reference.snapshots();
  User? user = FirebaseAuth.instance.currentUser;
  

  //_reference.get()  ---> returns Future<QuerySnapshot>
  //_reference.snapshots()--> Stream<QuerySnapshot> -- realtime updates
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProductScreen())),
        // onPressed: () => Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(
        //         builder: (BuildContext context) => NewTemplate())),
        backgroundColor: Color(0xff4B56D2),
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      // body: Column(
      //   children: [
      //     Container(
      //       color: Colors.white,
      //       margin: EdgeInsets.fromLTRB(0, 15, 0, 7),
      //       child: Padding(
      //         padding: EdgeInsets.fromLTRB(20, 4, 15, 7),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children: [],
      //         ),
      //       ),
      //     ),
      //     // Container(
      //     //   child: Text('Title:' + title.toString()),
      //     // )
      //   ],
      // )
      body: StreamBuilder<QuerySnapshot>(
        stream:FirebaseFirestore.instance
            .collection('pages')
            .where('uid', isEqualTo:user?.uid )
            .snapshots(),
        builder: ( context, snapshot) {
          //Check error
          if (!snapshot.hasData) {
            return Center(child: Text("No media uploaded Yet!!"));
          }
          //Check if data arrived
          if (snapshot.hasData) {
            //get the data
            QuerySnapshot? querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot!.docs;

            //Convert the documents to Maps
            List<Map> items = documents.map((e) => e.data() as Map).toList();

            //Display the list as grid of tiles
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                //Get the item at this index
                Map thisItem = items[index];
                //Return the widget for the grid item
                return Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage('${thisItem['images']}'),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('${thisItem['title']}'),
                        // subtitle: Text('${thisItem['description']}'),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          //Show loader
          return Center(child: CircularProgressIndicator());
        },
      ),
      //Display a list // Add a FutureBuilder
    );
  }
}

// class pages extends StatelessWidget {
//   pages({Key? key}) : super(key: key) {
//     _stream = _reference.snapshots();
//   }

//   CollectionReference _reference =
//       FirebaseFirestore.instance.collection('pages');

//   //_reference.get()  ---> returns Future<QuerySnapshot>
//   //_reference.snapshots()--> Stream<QuerySnapshot> -- realtime updates
//   late Stream<QuerySnapshot> _stream;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Navigator.push(
//             context, MaterialPageRoute(builder: (context) => ProductScreen())),
//         // onPressed: () => Navigator.of(context).pushReplacement(
//         //     MaterialPageRoute(
//         //         builder: (BuildContext context) => NewTemplate())),
//         backgroundColor: Color(0xff4B56D2),
//         child: Icon(Icons.add),
//       ),
//       backgroundColor: Colors.white,
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _stream,
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           //Check error
//           if (snapshot.hasError) {
//             return Center(child: Text('Some error occurred ${snapshot.error}'));
//           }

//           //Check if data arrived
//           if (snapshot.hasData) {
//             //get the data
//             QuerySnapshot querySnapshot = snapshot.data;
//             List<QueryDocumentSnapshot> documents = querySnapshot.docs;

//             //Convert the documents to Maps
//             List<Map> items = documents.map((e) => e.data() as Map).toList();

//             //Display the list
//             return ListView.builder(
//                 itemCount: items.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   //Get the item at this index
//                   Map thisItem = items[index];
//                   //REturn the widget for the list items
//                   return ListTile(
//                     title: Text('${thisItem['title']}'),
//                     subtitle: Text('${thisItem['description']}'),
//                     // leading: Container(
//                     //   height: 80,
//                     //   width: 80,
//                     //   child: thisItem.containsKey('images')
//                     //       ? Image.network('${thisItem['images']}')
//                     //       : Container(),
//                     // ),
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => previedPage(thisItem['id'])));
//                     },
//                   );
//                 });
//           }

//           //Show loader
//           return Center(child: CircularProgressIndicator());
//         },
//       ), //Display a list // Add a FutureBuilder
//     );
//   }
// }





// StreamBuilder<QuerySnapshot>(
//         stream: _stream,
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           //Check error
//           if (snapshot.hasError) {
//             return Center(child: Text('Some error occurred ${snapshot.error}'));
//           }

//           //Check if data arrived
//           if (snapshot.hasData) {
//             //get the data
//             QuerySnapshot querySnapshot = snapshot.data;
//             List<QueryDocumentSnapshot> documents = querySnapshot.docs;

//             //Convert the documents to Maps
//             List<Map> items = documents.map((e) => e.data() as Map).toList();

//             //Display the list
//             return ListView.builder(
//                 itemCount: items.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   //Get the item at this index
//                   Map thisItem = items[index];
//                   //REturn the widget for the list items
//                   return ListTile(
//                     title: Text('${thisItem['title']}'),
//                     subtitle: Text('${thisItem['description']}'),
//                     leading: Container(
//                       height: 80,
//                       width: 80,
//                       child: thisItem.containsKey('images')
//                           ? Image.network('${thisItem['images']}')
//                           : Container(
//                               child: Icon(Icons.add),
//                             ),
//                     ),
//                   );
//                 });
//           }

//           //Show loader
//           return Center(child: CircularProgressIndicator());
//         },
//       ),