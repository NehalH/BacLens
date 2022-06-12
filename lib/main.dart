import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:del04/splashscreen.dart';
import 'package:del04/page/info_page.dart';
import 'package:del04/data.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:iconsax/iconsax.dart';

late String name, path , domain , phylum , clas , order , family , genus , species ;
File? _photo;

// ignore: prefer_typing_uninitialized_variables
var image;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => const Splash_screen(),
            '/home': (context) => ImageUploads(),
            '/home/info_page': (context) => Info_page()
          }
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


  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        image= _photo;
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
        image= _photo;
      } else {
        // ignore: avoid_print
        print('No image selected.');
      }
    });
  } //from Camera

  Future uploadFile() async {
    if (_photo == null) return;
    const destination = 'Very_Danger_Bacteria/';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
    }
    catch (e) {
      if (kDebugMode) {
        print('Error occurred, try again.');
      }
    }
  }

  void _onLoading() {
    showDialog(
      context: context,
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

    douploadingshit();
    Future.delayed(const Duration(seconds: 10), () async {
      Navigator.pop(context); //pop dialog
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('BacDetect/Res').get();
      name = (snapshot.value) as String;

      const Data().setData();

      if(name=='nill'){
        fetch_errorM();
      }
      else{
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Info_page()));

      }
    });
  }

  Future<void> douploadingshit() async {
    uploadFile();
    DatabaseReference ref = FirebaseDatabase.instance.ref("");
    await ref.update({
      "confirm/state": "yes",
    });
  }

  void fetch_errorM() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(height: 80, width: 30),
              Text("Could not analyze sample.\nPlease Retry or try another Image."),
            ],
          ),
        );
      },
    );
    Future.delayed(const Duration(seconds: 2), () async {
      Navigator.pop(context); //pop dialog
    });
  }

  //----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('\t Baclens'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 80,),
            Text('Upload your image file', style: TextStyle(fontSize: 25, color: Colors.grey.shade800, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            Text('File should be jpg or png only', style: TextStyle(fontSize: 15, color: Colors.grey.shade500),),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    dashPattern: const [10, 5],
                    strokeCap: StrokeCap.round,
                    color: Colors.grey.shade900,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade50.withOpacity(.3),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.document_upload5, color: Colors.grey.shade900, size: 40,),
                          const SizedBox(height: 15,),
                          Text('Click to choose image', style: TextStyle(fontSize: 15, color: Colors.grey.shade400),),
                        ],
                      ),
                    ),
                  )
              ),
            ),
            _photo != null
                ? Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('            Selected File:',
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 15,  ),),
                    const SizedBox(height:10),
                    Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1),
                            color: Colors.transparent,
                        ),
                        child: Center(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: Image.file(_photo!, width: 200, height: 200, fit: BoxFit.fitWidth)
                          ),
                        )
                    ),
                    const SizedBox(height: 30,),
                     MaterialButton(
                       minWidth: double.infinity,
                       height: 50,
                       onPressed: () {
                         _onLoading();
                       },
                       color: Colors.blueGrey.shade900,
                       child: const Text('Upload', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                     )
                  ],
                ))
                : Container(),
            const SizedBox(height: 150,),
          ],
        ),
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
}