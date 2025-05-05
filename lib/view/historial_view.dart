import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HistorialView extends StatefulWidget {
  const HistorialView({super.key});

  @override
  State<HistorialView> createState() => _HistorialViewState();
}

class _HistorialViewState extends State<HistorialView> {
  File? _image;
  final picker = ImagePicker();

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print('Imagen guardada ${_image.runtimeType}');
        // widget.imgUrl null;
      } else {
        print('No Image Picked');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            InkWell(
              onTap: () {
                getImageGallery();
              },
              child: Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: _image != null
                      ? Image.file(
                          _image!.absolute,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 30,
                        ))),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                getImageGallery();
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    'Upload',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
