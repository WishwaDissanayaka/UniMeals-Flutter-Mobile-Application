import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(const MyPdfViewer());
}

class MyPdfViewer extends StatefulWidget {
  const MyPdfViewer({super.key});

  @override
  State<MyPdfViewer> createState() => _MyPdfViewerState();
}

class _MyPdfViewerState extends State<MyPdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            text: 'Hotel Details',
            style: TextStyle(
              color: Colors.black,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            children: [],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 92, 247, 26),
        centerTitle: true,
        toolbarHeight: 100,
      ),
      body: SfPdfViewer.asset("assets/cv.pdf"),
    );
  }
}
