import 'package:brew_crew/screens/home/srceen1/upload_excel.dart';
import 'package:flutter/material.dart';

// class Excel extends StatelessWidget {
//   const Excel({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: ExcelPage(),
//     );
//   }
// }

class ExcelPage extends StatelessWidget {
  const ExcelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // shape: const Border(
        //   bottom: BorderSide(
        //     color: Color(0xffC8C6C6),
        //     width: 0.3,
        //   ),
        // ),
        backgroundColor: Colors.white,
        title: const Text("Upload Excel",
            style: TextStyle(fontFamily: "Montserrat", color: Colors.black)),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          tooltip: 'Show Snackbar',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
        child: Column(
          children: [
            const SizedBox(
              height: 38,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromRGBO(50, 50, 93, 0.25).withOpacity(0.1),
                    // color:
                    //     const Color.fromRGBO(50, 50, 93, 0.25).withOpacity(0.1),
                    spreadRadius: 10,
                    blurRadius: 20,
                    offset: const Offset(0, 8), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.article_outlined,
                    size: 35,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      "EXCEL FILE.xls",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              // : EdgeInsets.all(5),
            ),
            const SizedBox(
              height: 23,
            ),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: 23,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(0, 0, 0, 0.13),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xffffffff)),
                child: const Center(
                    child: Text(
                  "UPLOAD ANOTHER",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Color(0xff000000),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
            const SizedBox(
              height: 23,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffF55050),
                ),
                child: const Center(
                    child: Text(
                  "DELETE",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Color(0xffffffff),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadExcel(),
                      ),
                    );
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffA85CF9),
                    ),
                    child: const Center(
                      child: Text(
                        "PROCEED",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Color(0xffECF2FF),
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
