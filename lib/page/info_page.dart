// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:del04/main.dart';
import '../api/pdf_api.dart';
import 'package:del04/page/pdf_viewer_page.dart';


// ignore: camel_case_types
class Info_page extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Info_page({Key? key}) : super(key: key);
  @override
  State<Info_page> createState() => _Info_pageState();
}

// ignore: camel_case_types
class _Info_pageState extends State<Info_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('\t Baclens'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Center(
        child: Column(
            children: <Widget>[
              const SizedBox(height: 50,),
              Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    color: Colors.transparent,
                  ),

                  child: Center(
                    child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: Image.file(image, width: 200, height: 200, fit: BoxFit.fitWidth)
                        ),
                        const SizedBox(height: 10,),
                        Text('$name\n', style: TextStyle(fontSize: 30, color: Colors.grey.shade800, fontWeight: FontWeight.bold),),
                      ],
                    )
                  )

              ),
              // ignore: prefer_const_constructors
              Column(
                children: [
                  // ignore: prefer_const_constructors
                  Text.rich( TextSpan(
                    children: <TextSpan>[
                      const TextSpan(text: 'Domain: \t', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                      TextSpan(text: '$domain\n\n', style: const TextStyle(fontSize: 18)),
                      const TextSpan(text: 'Phylum: \t', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                      TextSpan(text: '$phylum\n\n', style: const TextStyle(fontSize: 18)),
                      const TextSpan(text: "Class: \t", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                      TextSpan(text: '$clas\n\n', style: const TextStyle(fontSize: 18)),
                      const TextSpan(text: 'Order: \t', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                      TextSpan(text: '$order\n\n', style: const TextStyle(fontSize: 18)),
                      const TextSpan(text: 'Family: \t', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                      TextSpan(text: '$family\n\n', style: const TextStyle(fontSize: 18)),
                      const TextSpan(text: 'Genus: \t', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                      TextSpan(text: '$genus\n\n', style: const TextStyle(fontSize: 18)),
                      const TextSpan(text: 'Species: \t', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                      TextSpan(text: '$species\n\n', style: const TextStyle(fontSize: 18)),
                    ],
                  ),),
                  const SizedBox(height: 10,),
                  const Text('View PDF document for more information:', style: TextStyle(fontSize: 12, color: Colors.grey))
                ],
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 50),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  onPressed: () async {
                    /*const path = 'assets/pdfs/1.pdf';*/
                    final file = await PDFApi.loadAsset(path);
                    // ignore: use_build_context_synchronously
                    openPDF (context, file);
                  },
                  color: Colors.blueGrey.shade900,
                  child: const Text('Open PDF', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),

                ),
              )
            ]
        ),
      )
    );
  }
  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
  );
}