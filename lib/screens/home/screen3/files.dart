import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'upload_file.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/cupertino.dart';

class contentFilesScreen extends StatefulWidget {
  String? title, message;
  // const templates({super.key});̥̥

  contentFilesScreen({this.title, this.message});

  @override
  State<contentFilesScreen> createState() => _contentFilesScreenState();
}

class _contentFilesScreenState extends State<contentFilesScreen> {
  @override
  Widget build(BuildContext context) {
    void _openPdf(BuildContext context, String pdfUrl) {
      // Navigate to the PDF viewer screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SfPdfViewer.network(pdfUrl.toString()),
        ),
      );
    }

    void _deletePdf(BuildContext context, String pdfId) async {
      await FirebaseFirestore.instance.collection('pdfs').doc(pdfId).delete();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('PDF deleted successfully')));
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffA85CF9),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UploadFile()));

          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (BuildContext context) => const UploadFile()));
        },
        // foregroundColor: Colors.black,
        child: Icon(
          Icons.upload_file,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('pdfs')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text("No files uploaded Yet!!"));
          }
          List<DocumentSnapshot> pdfDocs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: pdfDocs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> pdfData =
                  pdfDocs[index].data() as Map<String, dynamic>;
              return ListTile(
                leading: Icon(Icons.picture_as_pdf),
                title: Text(pdfData['name']),
                // subtitle: Text('Uploaded by: ${pdfData['salesPersonUid']}'),
                trailing: IconButton(
                    icon: Icon(Icons.delete),
                    // onPressed: () => _deletePdf(context, pdfDocs[index].id),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => CupertinoAlertDialog(
                          content: const Text(
                            'Are you sure you want to delete this File?',
                            style: TextStyle(
                              fontFamily: "Montserrat",
                            ),
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text(
                                'Yes',
                                style:
                                    TextStyle(color: const Color(0XffA85CF9)),
                              ),
                              onPressed: () {
                                _deletePdf(context, pdfDocs[index].id);
                                Navigator.of(context).pop();
                              },
                            ),
                            CupertinoDialogAction(
                              child: const Text('No',
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      color: const Color(0XffA85CF9))),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                onTap: () => _openPdf(context, pdfData['url']),
              );
            },
          );
        },
      ),
    );
  }
}
