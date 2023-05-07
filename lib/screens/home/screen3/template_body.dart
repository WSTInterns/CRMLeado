


// import 'package:flutter/material.dart';
// import './data.dart';
// import './newmessage_template.dart';

// void main() {
//   runApp(templates());
// }

// class templates extends StatelessWidget {
//   String? title, message;
//   // const templates({super.key});

//   templates({this.title, this.message});

//   @override
//   Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: Scaffold(
    //       body: Padding(
    //     padding: EdgeInsets.all(15),
    //     child: Row(
    //       children: [
    //         Text('sorting'),
    //         IconButton(
    //           onPressed: null,
    //           icon: Icon(Icons.keyboard_arrow_down),
    //           padding: EdgeInsets.fromLTRB(20, 15, 15, 15),
    //         )
    //       ],
    //     ),

    //   ),),
    // );

//     return Scaffold(
//       body: SafeArea(
//           child: Column(
//         children: [
//           Row(
//             children: [
//               Text('Sorting [A-Z]'),
//               IconButton(onPressed: null, icon: Icon(Icons.keyboard_arrow_down))
//             ],
//           ),
          // Text('Title:' + title.toString()),
          // Text('message:' + message.toString())
//         ],
//       )),
//     );
//   }
// }























// class templates extends StatefulWidget {
//   String? title, message;

//   templates({this.title, this.message});
//   @override
//   State<templates> createState() => _templatesState();
// }

// // ignore: camel_case_types
// class _templatesState extends State<templates> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(body: SafeArea(child: Column(children: [Text('Title:'+title.toString())],)),),
//     );
    // Container(
    //   color: Colors.white,
    //   margin: const EdgeInsets.fromLTRB(0, 50, 0, 50),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: const <Widget>[
    //       Text(
    //         'Sorting by Title [A-Z]',
    //         textAlign: TextAlign.left,
    //         style: TextStyle(
    //           fontSize: 15,
    //         ),
    //       ),
    //       Divider(
    //         color: Colors.black,
    //         thickness: 1,
    //       ),
    //       Text(
    //         'This is some text',
    //         style: TextStyle(
    //           fontSize: 18,
    //         )),
    //     ],
    //   ),
    // );
  // }

//   Widget getRow(int index) {
//     return Card(
//         child: ListTile(
//             title: Column(
//       children: [Text(data[index].title), Text(data[index].message)],
//     )));
//   }
// }
