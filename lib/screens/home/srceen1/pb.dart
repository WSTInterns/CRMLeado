import 'package:brew_crew/screens/home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math';
import 'package:brew_crew/screens/home/srceen1/register.dart';

Map<int, Color> color = {
  50: const Color(0xffA85CF9),
  100: const Color(0xffA85CF9),
  200: const Color(0xffA85CF9),
  300: const Color(0xffA85CF9),
  400: const Color(0xffA85CF9),
  500: const Color(0xffA85CF9),
  600: const Color(0xffA85CF9),
  700: const Color(0xffA85CF9),
  800: const Color(0xffA85CF9),
  900: const Color(0xffA85CF9),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: ((context, child) => PhoneScreen()),
    );
  }
}

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  List<Contact> contacts = [];
  int selectedIndex = -1;
  bool isLoading = true;
  List<Contact> foundUsers = [];

  @override
  initState() {
    // TODO: implement initState
    foundUsers = contacts;
    super.initState();
    getContactPermission();
  }

  void getContactPermission() async {
    if (await Permission.contacts.isGranted) {
      await fetchContacts();
    } else {
      await Permission.contacts.request();
    }
  }

  fetchContacts() async {
    contacts = await ContactsService.getContacts();
    print('contacts: ${contacts[0].displayName}');
    setState(() {
      isLoading = false;
    });
  }

  void _runFilter(String enteredKeyword) {
    List<Contact> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = contacts;
    } else {
      results = contacts
          .where((user) => user.givenName!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          tooltip: 'Show Snackbar',
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomeBar(
                      title: '',
                    )
                    ));
          },
        ),
        centerTitle: true,
        title: Text(
          "Contacts",
          style: TextStyle(
            fontFamily: "Montserrat",
          ),
        ),
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back_ios,
        //     color: Colors.white,
        //   ),
        //   tooltip: 'Back',
        //   onPressed: () {
        //     Navigator.of(context)
        //         .push(MaterialPageRoute(builder: (context) => HomeBar(title: '',)));
        //   },
        // ),
      ),
      body:
          // isLoading
          //     ? Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     :
          Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: foundUsers.isNotEmpty
                        ? ListView.builder(
                            itemCount: foundUsers.length,
                            itemBuilder: (context, index) {
                              if (this.isLoading == true) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return ListTile(
                                  leading: Container(
                                    height: 30.h,
                                    width: 30.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 2.5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color.fromRGBO(
                                                  50, 50, 93, 0.25)
                                              .withOpacity(0.08),
                                          // color: const Color.fromRGBO(0, 0, 0, 0.3).withOpacity(0.1),
                                          spreadRadius: 10,
                                          blurRadius: 20,
                                          offset: const Offset(0,
                                              8), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(6.r),
                                      color: Color(0xffA85CF9),
                                    ),
                                    child: Text(
                                      foundUsers[index].givenName![0],
                                      style: TextStyle(
                                        fontSize: 23.sp,
                                        color: Colors.primaries[Random()
                                            .nextInt(Colors.primaries.length)],
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    foundUsers[index].givenName!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  // subtitle: Text(
                                  //   foundUsers[index].phones![0].value!,
                                  //   style: TextStyle(
                                  //     fontSize: 11.sp,
                                  //     // color: const Color(0xffC4c4c4),
                                  //     color: Colors.white,
                                  //     fontFamily: "Montserrat",
                                  //     fontWeight: FontWeight.w400,
                                  //   ),
                                  // ),
                                  horizontalTitleGap: 12.w,
                                  trailing: Checkbox(
                                    checkColor: Colors.white,
                                    // fillColor: MaterialStateProperty.resolveWith(getColor),
                                    value:
                                        selectedIndex == index ? true : false,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (!value!) {
                                          selectedIndex = -1;
                                        } else {
                                          selectedIndex = index;
                                        }
                                      });
                                    },
                                  ),
                                );
                              }
                            },
                          )
                        : ListView.builder(
                            itemCount: contacts.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Container(
                                  height: 30.h,
                                  width: 30.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color.fromRGBO(50, 50, 93, 0.25),
                                        width: 2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromRGBO(
                                                50, 50, 93, 0.25)
                                            .withOpacity(0.08),
                                        // color: const Color.fromRGBO(0, 0, 0, 0.3).withOpacity(0.1),
                                        spreadRadius: 10,
                                        blurRadius: 20,
                                        offset: const Offset(
                                            0, 8), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(6.r),
                                    // color: Color(0xffA85CF9),
                                  ),
                                  child: Text(
                                    contacts[index].givenName![0],
                                    style: TextStyle(
                                      fontSize: 23.sp,
                                      color: Colors.primaries[Random()
                                          .nextInt(Colors.primaries.length)],
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  contacts[index].givenName!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                // subtitle: Text(
                                //   contacts[index].phones![0].value!,
                                //   style: TextStyle(
                                //     fontSize: 11.sp,
                                //     color: const Color(0xffC4c4c4),
                                //     fontFamily: "Poppins",
                                //     fontWeight: FontWeight.w400,
                                //   ),
                                // ),
                                horizontalTitleGap: 12.w,
                                trailing: Checkbox(
                                  checkColor: Colors.white,
                                  // fillColor: MaterialStateProperty.resolveWith(getColor),
                                  value: selectedIndex == index ? true : false,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (!value!) {
                                        selectedIndex = -1;
                                      } else {
                                        selectedIndex = index;
                                      }
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                ],
              )),
      floatingActionButton: selectedIndex != -1
          ? ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StoreContact(
                            '${contacts[selectedIndex].displayName}',
                            contacts[selectedIndex].phones?.first.value ?? '',
                          )),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.fromLTRB(10, 18, 10, 18),
                child: const Text(
                  'Import Contact',
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 17,
                  ),
                ),
              ),
            )
          : Container(),
    );
  }
}
/*import 'package:contact/register.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: ((context, child) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const PhoneScreen(),
            themeMode: ThemeMode.dark,
            darkTheme: ThemeData.dark(),
          )),
    );
  }
}

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  List<Contact> contacts = [];
  int selectedIndex = -1;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContactPermission();
  }

  void getContactPermission() async {
    if (await Permission.contacts.isGranted) {
      await fetchContacts();
    } else {
      await Permission.contacts.request();
    }
  }

  fetchContacts() async {
    contacts = await ContactsService.getContacts();
    print('contacts: ${contacts[0].displayName}');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
            children: [
              
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Container(
                          height: 30.h,
                          width: 30.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 7,
                                color: Colors.white.withOpacity(0.1),
                                offset: const Offset(-3, -3),
                              ),
                              BoxShadow(
                                blurRadius: 7,
                                color: Colors.black.withOpacity(0.7),
                                offset: const Offset(3, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(6.r),
                            color: Color(0xff262626),
                          ),
                          child: Text(
                            contacts[index].givenName![0],
                            style: TextStyle(
                              fontSize: 23.sp,
                              color: Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)],
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        title: Text(
                          contacts[index].givenName!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.cyanAccent,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          contacts[index].phones![0].value!,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: const Color(0xffC4c4c4),
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        horizontalTitleGap: 12.w,
                        trailing: Checkbox(
                          checkColor: Colors.white,
                          // fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: selectedIndex == index ? true : false,
                          onChanged: (bool? value) {
                            setState(() {
                              if (!value!) {
                                selectedIndex = -1;
                              } else {
                                selectedIndex = index;
                              }
                            });
                          },
                        ),
                      );
                    },
                  ),
              ),
            ],
          ),
      floatingActionButton: selectedIndex != -1
          ? ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          //  const UserDetails()
                          StoreContact(
                            '${contacts[selectedIndex].displayName}',
                          contacts[selectedIndex].phones?.first.value ?? '',
                          )),
                );
              },
              child: const Text('Import Contact'),
            )
          : Container(),
    );
  }
}
*/
/*import 'package:contact/register.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: ((context, child) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const PhoneScreen(),
            themeMode: ThemeMode.dark,
            darkTheme: ThemeData.dark(),
          )),
    );
  }
}

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  List<Contact> contacts = [];
  int selectedIndex = -1;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContactPermission();
  }

  void getContactPermission() async {
    if (await Permission.contacts.isGranted) {
      await fetchContacts();
    } else {
      await Permission.contacts.request();
    }
  }

  fetchContacts() async {
    contacts = await ContactsService.getContacts();
    print('contacts: ${contacts[0].displayName}');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
            children: [
              
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Container(
                          height: 30.h,
                          width: 30.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 7,
                                color: Colors.white.withOpacity(0.1),
                                offset: const Offset(-3, -3),
                              ),
                              BoxShadow(
                                blurRadius: 7,
                                color: Colors.black.withOpacity(0.7),
                                offset: const Offset(3, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(6.r),
                            color: Color(0xff262626),
                          ),
                          child: Text(
                            contacts[index].givenName![0],
                            style: TextStyle(
                              fontSize: 23.sp,
                              color: Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)],
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        title: Text(
                          contacts[index].givenName!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.cyanAccent,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          contacts[index].phones![0].value!,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: const Color(0xffC4c4c4),
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        horizontalTitleGap: 12.w,
                        trailing: Checkbox(
                          checkColor: Colors.white,
                          // fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: selectedIndex == index ? true : false,
                          onChanged: (bool? value) {
                            setState(() {
                              if (!value!) {
                                selectedIndex = -1;
                              } else {
                                selectedIndex = index;
                              }
                            });
                          },
                        ),
                      );
                    },
                  ),
              ),
            ],
          ),
      floatingActionButton: selectedIndex != -1
          ? ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          //  const UserDetails()
                          StoreContact(
                            '${contacts[selectedIndex].displayName}',
                          contacts[selectedIndex].phones?.first.value ?? '',
                          )),
                );
              },
              child: const Text('Import Contact'),
            )
          : Container(),
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Contents extends StatelessWidget {
  const Contents({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(

          appBar: AppBar(
            title: Container(

              //alignment: Alignment.topLeft,
              alignment: Alignment.center,
              width: double.infinity,
              height: 40,
              color: Colors.white,
         // decoration: BoxDecoration(border:Border.all(width: 4,color: Colors.black,),borderRadius: BorderRadius.circular(22),),
              child: const Center(
                child: TextField(
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(12),
                    // ),+
                    
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
                  text: 'Messages',
                ),
                Tab(
                  text: 'Files',
                ),
                Tab(
                  text: 'Pages',
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
