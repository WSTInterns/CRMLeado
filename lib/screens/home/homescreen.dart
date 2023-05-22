import 'package:flutter/material.dart';
// import 'package:radhe/Followup.dart';
// import 'package:radhe/client.dart';
// import 'package:radhe/contents.dart';
// import 'package:radhe/more.dart';
import 'client.dart';
import 'contents.dart';
import 'Followup.dart';
import 'more.dart';

// const MaterialColor myColor =
//     const MaterialColor(0xff4B56D2, const <int, Color>{
//   50: const Color(0xff4B56D2),
// });
Map<int, Color> color = {
  50: const Color(0xff4B56D2),
  100: const Color(0xff4B56D2),
  200: const Color(0xff4B56D2),
  300: const Color(0xff4B56D2),
  400: const Color(0xff4B56D2),
  500: const Color(0xff4B56D2),
  600: const Color(0xff4B56D2),
  700: const Color(0xff4B56D2),
  800: const Color(0xff4B56D2),
  900: const Color(0xff4B56D2),
};

// class HomeBar extends StatelessWidget {
//   const HomeBar({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: MaterialColor(0xff4B56D2, color),
//       ),
//       home: const HomeBar(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

class HomeBar extends StatefulWidget {
  const HomeBar({super.key, required this.title});
  final String title;
  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  List pages = [
    HomePage1(),
    Contents(),
    Follow(),
    Moree(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xff4B56D2),
          onTap: onTap,
          elevation: 0,
          selectedLabelStyle: TextStyle(fontFamily: "Montserrat"),
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
          ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'package:radhe/Followup.dart';
import 'package:radhe/client.dart';
import 'package:radhe/contents.dart';
import 'package:radhe/more.dart';

void main() {
  runApp(const HomeBar());
}

class HomeBar extends StatelessWidget {
  const HomeBar({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomeBar(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomeBar extends StatefulWidget {
  const HomeBar({super.key, required this.title});
  final String title;
  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  List pages=[
    HomePage(),
Contents(),
Follow(),
Moree(),
  ];
  int currentIndex=0;
  void onTap(int index)
  {
setState(() {
  currentIndex=index;
});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black54,
          onTap: onTap,
          currentIndex: currentIndex,
          unselectedItemColor:Colors.grey.withOpacity(0.5),
          items: [
            BottomNavigationBarItem(label: "Clients", icon: Icon(Icons.apps)),//clients
            BottomNavigationBarItem(label: "Contents",icon: Icon(Icons.bar_chart)),//content
            BottomNavigationBarItem(label: "Follow Ups",icon: Icon(Icons.follow_the_signs)),//follow
            BottomNavigationBarItem(label: "More",icon: Icon(Icons.more)),//more
          ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/
