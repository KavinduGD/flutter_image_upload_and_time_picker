import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        pickedFile = result.files.first;
      });
    }
  }

  uploadFile() async {
    if (pickedFile == null) {
      // Handle the case where no file is selected
      return;
    }

    final path = "files/${pickedFile!.name}";
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() => {});
    final url = await snapshot.ref.getDownloadURL();
    print("Download URL: $url");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (pickedFile != null)
                Expanded(
                  child: Container(
                    color: Colors.grey[200],
                    width: double.infinity,
                    child:
                        Image.file(File(pickedFile!.path!), fit: BoxFit.cover),
                  ),
                ),
              ElevatedButton(onPressed: selectFile, child: Text("Select File")),
              ElevatedButton(onPressed: uploadFile, child: Text("Upload File")),
            ],
          ),
        ));
  }
}
