import 'dart:io';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:del04/api/pdf_api.dart';
import 'package:del04/page/pdf_viewer_page.dart';

/*void main() {

  runApp(
      MaterialApp(
        title: "Pick Image Camera",
        home: ImageUploads() ,
      )
  );
}*/   //main fn that doesn't work, but don't know why

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      const MaterialApp(
        title: "Pick Image",
        home: ImageUploads() ,
      )
  );
}

class ImageUploads extends StatefulWidget {
  const ImageUploads({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ImageUploadsState createState() => _ImageUploadsState();
}

class _ImageUploadsState extends State<ImageUploads> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        /*uploadFile();*/
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        /*uploadFile();*/
      } else {
        // ignore: avoid_print
        print('No image selected.');
      }
    });
  } //from Camera

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
    }
    catch (e) {
      if (kDebugMode) {
        print('error occured');
      }
    }
  }

  void _onLoading() {
    showDialog(
      context: this.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(height: 80, width: 80),
              CircularProgressIndicator(),
              Text("   Analyzing..."),
            ],
          ),
        );
      },
    );
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(this.context); //pop dialog
      uploadFile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('\t Baclens'),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 32,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 150,
                backgroundColor: Colors.transparent,
                child: _photo != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.zero,
                  child: Image.file(
                    _photo!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.fitWidth,
                  ),
                )
                    : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,

                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3.0,
                          offset: Offset(1.0, 1.0))
                    ],
                  ),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _onLoading();
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            child: const Text('Upload'),
          ),

          Container(
            width: 400,
            height: 60,
            padding: const EdgeInsets.fromLTRB(5.0, 39.0, 0.0, 2.0),
              child: const Text("\t  Common Name:")
          ),


          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,

                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1.0,
                      offset: Offset(0.2, 0.2))
                ],
              ),
              width: 375,
              height: 60,
              child: Column(
                children: const [
                  Expanded(child: Text("")),
                ],
              )
          ),

          Container(
              width: 400,
              height: 30,
              padding: const EdgeInsets.fromLTRB(5.0, 10.0, 0.0, 2.0),
              child: const Text("\t  Scientific Name:")
          ),

          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,

                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1.0,
                      offset: Offset(0.2, 0.2))
                ],
              ),
              width: 375,
              height: 60,
              child: Column(
                children: const [
                  Expanded(child: Text("")),
                ],
              )
          ),
          Container(
              /*width: 400,
              height: 20,*/
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: Column(
              children: [
                const Text("View PDF Document for more Information:"),
                ElevatedButton(

                  onPressed: () async {
                    const path = 'assets/pdfs/1.pdf';
                    final file = await PDFApi.loadAsset(path);
                    // ignore: use_build_context_synchronously
                    openPDF(context, file);
                  },

                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold),),

                  child: const Text('View PDF'),

                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[

                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),

                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
  );

}