import 'package:brew_crew/screens/home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math';
import 'package:brew_crew/screens/home/srceen1/register.dart';

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

class MyAppPb extends StatelessWidget {
  const MyAppPb({super.key});

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
                    )));
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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: foundUsers.isNotEmpty
                        ? ListView.builder(
                            itemCount: foundUsers.length,
                            itemBuilder: (context, index) {
                              if (isLoading) {
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
                                      color: Color(0xff4B56D2),
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
                              if (isLoading) {
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
                                          color:
                                              Color.fromRGBO(50, 50, 93, 0.25),
                                          width: 2),
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
                                      // color: Color(0xff4B56D2),
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
