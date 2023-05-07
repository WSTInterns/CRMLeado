import 'package:flutter/material.dart';

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: EditTemplate(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

class EditTemplate extends StatefulWidget {
  const EditTemplate({super.key});

  @override
  State<EditTemplate> createState() => _EditTemplateState();
}

class _EditTemplateState extends State<EditTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios, color: Colors.black)),
              Text(
                "{Title}",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.black,
                    fontSize: 14),
              ),
              Padding(
                padding: EdgeInsets.only(left: 190),
                child: TextButton(
                    onPressed: () {
                      bottomsheet(context);
                    },
                    child: Text(
                      "Options",
                      style: TextStyle(
                          fontFamily: "Montserrat", color: Colors.black),
                    )),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Form(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 30),
                child: TextFormField(
                  // controller: titleController,
                  maxLines: null,

                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'e.g.Ask for coffee in next 3 days',
                      hintStyle: TextStyle(
                        fontFamily: "Montserrat",
                      )),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: 45,
                width: 270,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.send),
                  label: Text(
                    'SEND TO CLIENT',
                    style: TextStyle(
                        fontFamily: "Montserrat", color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xffA85CF9),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  void bottomsheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                dense: true,
                title: Text(
                  'Options',
                  style:
                      TextStyle(fontFamily: "Montserrat", color: Colors.black),
                ),
                tileColor: Colors.grey[100],
              ),
              Divider(
                thickness: 2,
                height: 5,
              ),
              ListTile(
                leading: Icon(Icons.edit),
                dense: true,
                title: Text(
                  'Edit message Template',
                  style: TextStyle(
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
              Divider(thickness: 2, height: 5),
              ListTile(
                leading: Icon(Icons.delete),
                dense: true,
                title: Text(
                  'Delete message Template',
                  style: TextStyle(
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
            ],
          );
        });
  }
}
