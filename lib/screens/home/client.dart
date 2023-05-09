import 'package:brew_crew/screens/home/srceen1/leadmain.dart';
import 'package:brew_crew/screens/home/srceen1/leadmain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'phone.dart';

class HomePage1 extends StatefulWidget {
  //const HomePage1({Key? key}) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xFF4B56D2),
            // title: Container(
            //   //alignment: Alignment.topLeft,
            //   width: double.infinity,

            //   height: 40,
            //   color: Colors.white,
            //   child: const Center(
            //     child: TextField(
            //       decoration: InputDecoration(
            //         hintText: 'Search for something',
            //         hintStyle: TextStyle(fontFamily: "Montserrat"),
            //         prefixIcon: Icon(Icons.search),
            //       ),
            //     ),
            //   ),
            // ),
            // title: Text('Clients'),
            centerTitle: true,
            title: TabBar(
              tabs: const [
                Tab(
                  child: Text(
                    'All Clients',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    'Groups',
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
            children: [
              Center(child: Scaffold(body: phonebook())),

// <<<<<<< Updated upstream
              Center(child: Scaffold(body: MyHomePage())),
// =======
              // Center(child: Scaffold(body: MyHomePage())),
// >>>>>>> Stashed changes
            ],
          ),
        ));
  }
}
/*
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:radhe/phone.dart';
class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      
        length: 3,
        child: Scaffold(

          appBar: AppBar(
            title: Container(
              //alignment: Alignment.topLeft,
              width: double.infinity,
              height: 40,
              color: Colors.white,
              child: const Center(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for something',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            centerTitle: true,
            bottom: TabBar(
              tabs:[
                Tab(
                  text: 'All Clients',
                ),
                Tab(
                  text: 'Team',
                ),
                Tab(
                  text: 'Groups',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: Scaffold(
                  body:phonebook()
                )

              ),
              Center(
                child: Text('Status Page'),
              ),
              Center(
                child: Text('Calls Page'),
              ),
              
            ],
          ),
        ));
  }
}

*/
/*
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:op/phone.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage1(),
    );
  }
}

class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({Key? key}) : super(key: key);

  @override
  _MyHomePage1State createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
          if(isDialOpen.value){
            isDialOpen.value = false;
            return false;
          }else{
            return true;
          }
      },
      child: Scaffold(
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          openCloseDial: isDialOpen,
          backgroundColor: Colors.redAccent,
          overlayColor: Colors.grey,
          overlayOpacity: 0.5,
          spacing: 15,
          spaceBetweenChildren: 15,
          closeManually: true,
          children: [
            SpeedDialChild(
              child: Icon(Icons.share_rounded),
              label: 'Share',
              backgroundColor: Colors.blue,
              onTap: (){
                print('Share Tapped');
              }
            ),
            SpeedDialChild(
              child: Icon(Icons.mail),
              label: 'Mail',
                onTap: (){
                  print('Mail Tapped');
                }
            ),
            SpeedDialChild(
              child: Icon(Icons.copy),
              label: 'Copy',
                onTap: (){
                  print('Copy Tapped');
                }
            ),
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          child: const Text("FAB Menu Example",style: TextStyle(fontSize: 30),),
        ),
      ),
    );
  }
}
*/
/*import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(

          appBar: AppBar(
            title: Container(
              //alignment: Alignment.topLeft,
              width: double.infinity,
              height: 40,
              color: Colors.white,
              child: const Center(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for something',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'All Clients',
                ),
                Tab(
                  text: 'Team',
                ),
                Tab(
                  text: 'Groups',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: Text('Chats Page'),
              ),
              Center(
                child: Text('Status Page'),
              ),
              Center(
                child: Text('Calls Page'),
              ),
              
            ],
          ),
        ));
  }
}
*/