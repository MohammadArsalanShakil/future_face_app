import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_face_app/constants/urls.dart';
import 'package:future_face_app/controllers/check_url_status.dart';
import 'package:http/http.dart' as http;
import '/models/processed_image.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  File? imageFile;
  Uint8List? imgBytes;

  Future<void> uploadFileToServer(BuildContext context, String url, File image,
      {double ageValue = 65.0}) async {
    bool isURLValid = await checkURL(url);
    if (isURLValid) {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      var fileToPost = await http.MultipartFile.fromPath('img', image.path,
          filename: image.path);
      request.files.add(fileToPost);
      request.fields['age'] = ageValue.toInt().toString();

      request.send().then((streamResponse) {
        http.Response.fromStream(streamResponse).then((responce) {
          if (responce.statusCode == 200) {
            Map<String, dynamic> imgResponsemap = jsonDecode(responce.body);
            ProcessedImage imgResponse =
                ProcessedImage.fromJson(imgResponsemap);

            imgBytes = const Base64Decoder().convert(imgResponse.s0!);
            imgBytes = Uint8List.fromList(imgBytes!);

            setState(() {
              imageFile = File.fromRawPath(imgBytes!);
            });
          } else if (responce.statusCode == 500) {
            print("Error 500");
          } else {
            print("Error");
          }
        });
      });
    } else {
      Fluttertoast.showToast(msg: 'Error', gravity: ToastGravity.CENTER);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (imageFile != null) {
        uploadFileToServer(context, futureFacePostURL, imageFile!,
            ageValue: 45.0);
      } else {
        print("Error loading file");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;

    setState(() {
      imageFile = data['image'];
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        actions: [
          InkWell(
            onTap: () {},
            child: const Icon(Icons.save, size: 30.0),
          ),
          const SizedBox(width: 10.0),
          InkWell(
            onTap: () {},
            child: const Icon(Icons.share, size: 30.0),
          ),
          const SizedBox(width: 20.0),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Color.fromRGBO(179, 111, 212, 1),
              Color.fromRGBO(103, 87, 186, 1),
            ],
          ),
        ),
        child: Container(
          margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash-bg.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (imgBytes == null)
                      ? const CircularProgressIndicator()
                      : CircleAvatar(
                          backgroundImage: MemoryImage(imgBytes!),
                          radius: 150.0,
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
