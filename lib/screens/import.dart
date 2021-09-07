import 'dart:io';
import 'package:flutter/material.dart';
import '/constants/theme.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImportScreen extends StatefulWidget {
  const ImportScreen({Key? key}) : super(key: key);

  @override
  State<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  File? imageFile, oldImageFile;

  Future pickImage(ImageSource source) async {
    oldImageFile = imageFile;

    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    setState(() {
      if (pickedImage != null) {
        print("Picker: Image loaded.");
        imageFile = File(pickedImage.path);
        cropAndResizeImage(imageFile!);
      } else {
        print("Picker: No image loaded.");
      }
    });
  }

  Future cropAndResizeImage(File imageFileToCrop) async {
    File? croppedImage = await ImageCropper.cropImage(
        sourcePath: imageFileToCrop.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 80,
        maxWidth: 1000,
        maxHeight: 1000,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Resize Image',
            toolbarColor: kPrimaryColor,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: kPrimaryColor,
            statusBarColor: kPrimaryColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          title: 'Resize Image',
        ));

    setState(() {
      if (croppedImage != null) {
        print("Cropper: Image cropped.");
        imageFile = croppedImage;
      } else {
        print("Cropper: Operation discarded.");
        imageFile = oldImageFile;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Import Image')),
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
          margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash-bg.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              (imageFile == null)
                  ? const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/user-avatar.png'),
                      radius: 150.0,
                    )
                  : CircleAvatar(
                      backgroundImage: FileImage(imageFile!),
                      radius: 150.0,
                    ),
              (imageFile == null) ? pickImageOptionsRow() : proceedOptionRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget pickImageOptionsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(20.0),
          constraints: const BoxConstraints(
            maxWidth: 200.0,
          ),
          width: 160.0,
          height: 130.0,
          child: ElevatedButton(
            onPressed: () {
              pickImage(ImageSource.gallery);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.photo_library,
                  color: Colors.white,
                  size: 30.0,
                ),
                SizedBox(height: 10.0),
                Text(
                  'Gallery',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20.0),
          constraints: const BoxConstraints(
            maxWidth: 200.0,
          ),
          width: 160.0,
          height: 130.0,
          child: ElevatedButton(
            onPressed: () {
              pickImage(ImageSource.camera);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera,
                  color: Colors.white,
                  size: 30.0,
                ),
                SizedBox(height: 10.0),
                Text(
                  'Camera',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget proceedOptionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(20.0),
          constraints: const BoxConstraints(
            maxWidth: 200.0,
          ),
          width: 160.0,
          height: 130.0,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/result',
                  arguments: {'image': imageFile});
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: Colors.white,
                  size: 30.0,
                ),
                SizedBox(height: 10.0),
                Text(
                  'Proceed',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}