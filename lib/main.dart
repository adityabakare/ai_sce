import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
//import 'dart:async';

String url = 'http://192.168.0.170:5000';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audiobook Generator',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _fileName;
  // List<PlatformFile>? _paths;
  //FilePickerResult result;
  String? _directoryPath;
  String? _filePath;
  late File file;
  bool? _loadingPath = false;
  var req = http.MultipartRequest('POST', Uri.parse(url));

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      // result = (await FilePicker.platform.pickFiles(
      //         type: FileType.custom,
      //         allowMultiple: false,
      //         allowedExtensions: ['pdf']))
      //
      //
      //    ?.files;
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        //File file =File(result.files.single.path);
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;

      // _fileName =
      //     _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      // _filePath =
      //     _paths != null ? _paths!.map((e) => e.path).toString() : '...';
      // if (_filePath != null) {
      //   // upload(_filePath.toString(), url);
      // }
    });
  }

  // Future<void> upload(String filename, String url) async {
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.files
  //       .add(await http.MultipartFile.fromPath('file', _filePath.toString()));
  //   var res = await request.send();
  //   print(res);
  // }
  // void _clearCachedFiles() {
  //   FilePicker.platform.clearTemporaryFiles().then((result) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: result! ? Colors.green : Colors.red,
  //         content: Text((result
  //             ? 'Temporary files removed with success.'
  //             : 'Failed to clean temporary files')),
  //       ),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Audiobook",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 50),
                ),
                Text(
                  "generator.",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 50),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Text(
                  "Please pick the file you want to convert",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextButton(
                  onPressed: () => _openFileExplorer(),
                  child: Text(
                    "Pick and Upload",
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue.shade900),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
