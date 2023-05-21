import 'package:brew_crew/screens/home/homescreen.dart';
import 'package:brew_crew/screens/home/srceen1/addmanual.dart';
import 'package:brew_crew/screens/home/srceen1/pb.dart';
import 'package:brew_crew/main.dart';
import 'package:brew_crew/screens/home/srceen1/upload_excel.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'dart:async';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartScreenPage(),
    );
  }
}

class StartScreenPage extends StatelessWidget {
  const StartScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff3C4048),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 75),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                  width: 145,
                  height: 145,
                  decoration: BoxDecoration(
                    color: Color(0xff4B56D2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Icon(
                          Icons.home_outlined,
                          size: 45,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "HOME",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  width: 145,
                  height: 145,
                  decoration: BoxDecoration(
                    color: Color(0xff4B56D2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UploadExcel(),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.table_chart,
                          size: 40,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "IMPORT EXCEL",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  width: 145,
                  height: 145,
                  decoration: BoxDecoration(
                    color: Color(0xff4B56D2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => manual(),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.contacts_rounded,
                          size: 40,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "ADD        CONTACT",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  width: 145,
                  height: 145,
                  decoration: BoxDecoration(
                    color: Color(0xff4B56D2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => MyAppPb(),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.contact_phone_sharp,
                          size: 40,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "PHONE       BOOK",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
