import 'package:app/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  _ImagesScreenState createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  TimeOfDay _time = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Images"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/imageupload-cec7e.appspot.com/o/files%2F647c1064ebf1c6171bfd3a87_profile-picture-feature-1.webp?alt=media&token=a5c8bfc5-0a56-4c2c-8e80-ab0801f780ef"),
                ),
              ),
            ),
            Text("Time: ${_time.format(context)}"),
            ElevatedButton(
              child: Text("add Time"),
              onPressed: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: _time,
                );
                if (time != null) {
                  setState(() {
                    _time = time;
                  });
                }
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
                child: const Text("Upload Image"),
                onPressed: () {
                  var profile = Profile(
                    image:
                        "https://firebasestorage.googleapis.com/v0/b/imageupload-cec7e.appspot.com/o/files%2F647c1064ebf1c6171bfd3a87_profile-picture-feature-1.webp?alt=media&token=a5c8bfc5-0a56-4c2c-8e80-ab0801f780ef",
                    time: "Time: ${_time.format(context)}",
                  );
                  FirebaseFirestore.instance.collection("profile").add(
                        profile.toJson(),
                      );
                }),
          ],
        ),
      ),
    );
  }
}
