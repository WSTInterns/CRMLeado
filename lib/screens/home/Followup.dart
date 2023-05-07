import 'package:brew_crew/screens/home/screen2/followmain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Follow extends StatelessWidget {
  const Follow({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: MyAppSak()
        // Scaffold(
        //     appBar: AppBar(
        //       title: Container(
        //         //alignment: Alignment.topLeft,
        //         width: double.infinity,
        //         height: 40,
        //         color: Colors.white,
        //         child: const Center(
        //           child: TextField(
        //             decoration: InputDecoration(
        //               hintText: 'Search for something',
        //               prefixIcon: Icon(Icons.search),
        //             ),
        //           ),
        //         ),
        //       ),
        //       centerTitle: true,
        //     ),
        //     body: MyAppSak()
        //     )
            );
  }
}
