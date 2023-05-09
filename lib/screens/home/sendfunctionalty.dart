import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:url_launcher/url_launcher.dart';

class SendFunction extends StatefulWidget {
  SendFunction(
      {super.key,
      required this.message,
      required this.title,
      required this.phoneNo,
      required this.email});
  String title, message, email;
  int phoneNo;

  @override
  State<SendFunction> createState() => _SendFunctionState();
}

class _SendFunctionState extends State<SendFunction> {
  final _formkey = GlobalKey<FormState>();
  String convertNewLine(String content) {
    print("Converting");
    return content.replaceAll(r'\n', '\n');
  }

  sendemail() async {
    final Uri emailUri = Uri(
        scheme: 'mailto',
        queryParameters: {},
        path: '${widget.email}',
        query: 'subject=${widget.title}&body=${widget.message}');
    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        throw FormatException('Could not mail $emailUri');
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open mail due to some error!!')),
      );
      print(e.toString());
    }
  }

  sendmessage() async {
    String phoneNumber = "${widget.phoneNo}";
    String message = "${widget.message}";
    String urlMessage = Uri.encodeFull(message);
    Uri uri = Uri.parse("whatsapp://send?phone=$phoneNumber&text=$urlMessage");
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not connect to $phoneNumber';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open WhatsApp due to some error!!')),
      );
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // body: Center(child: Text('${widget.title} ${widget.message}')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 30, 15, 20),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    // color: const Color.fromRGBO(
                    //         0, 0, 0, 0)
                    //     .withOpacity(0.04),
                    color: const Color.fromRGBO(50, 50, 93, 0.25)
                        .withOpacity(0.08),
                    // color:
                    //     const Color.fromRGBO(50, 50, 93, 0.25).withOpacity(0.1),
                    spreadRadius: 10,
                    blurRadius: 20,
                    offset: const Offset(0, 8), // changes position of shadow
                  ),
                ],
              ),
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  child: TextFormField(
                    maxLines: null, // Allows for unlimited lines of text
                    keyboardType: TextInputType.multiline,
                    onChanged: ((value) => widget.message = value),
                    initialValue: convertNewLine(widget.message),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'e.g.Your Message',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: InkWell(
              onTap: () {
                if (_formkey.currentState!.validate()) {
                  sendmessage();
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xff25D366),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                    child: Text(
                  "SEND VIA WHATSAPP",
                  style: TextStyle(
                    color: Color(0xffECF2FF),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: InkWell(
              onTap: () {
                if (_formkey.currentState!.validate()) {
                  sendemail();
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF4B56D2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                    child: Text(
                  "SEND VIA EMAIL",
                  style: TextStyle(
                    color: Color(0xffECF2FF),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
