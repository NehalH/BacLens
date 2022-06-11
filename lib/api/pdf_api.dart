import 'dart:async';
import 'package:flutter/services.dart';
// ignore: implementation_imports
import 'package:flutter/src/foundation/key.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:del04/page/info_page.dart';
import '../main.dart';

class PDFApi extends ImageUploads{
  const PDFApi({Key? key}) : super(key: key);

  static Future<File> loadAsset(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();

    return _storeFile(path, bytes);
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}