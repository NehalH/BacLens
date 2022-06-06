import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


import 'dart:io';

import '../main.dart';

class PDFApi extends ImageUploads{
  const PDFApi({Key? key}) : super(key: key);

  static Future<File> loadAsset(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();

    return _storeFile(path, bytes);
  }

  /*static Future<File> loadNetwork(String url) async {
    final response = await http.get(url);
    final bytes = response.bodyBytes;

    return _storeFile(url, bytes);
  }*/

  /*static Future<File> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null) return null;
    return File(result.paths.first);
  }*/

  /*static Future<File> loadFirebase(String url) async {
    try {
      final refPDF = FirebaseStorage.instance.ref().child(url);
      final bytes = await refPDF.getData();

      return _storeFile(url, bytes);
    } catch (e) {
      return null;
    }
  }*/

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}