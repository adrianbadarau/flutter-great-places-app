import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 160,
          height: 90,
          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text('No image', textAlign: TextAlign.center),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Expanded(
            child: FlatButton.icon(
                onPressed: _takePicture, icon: Icon(Icons.camera), label: Text('Take Picture'), textColor: Theme.of(context).primaryColor))
      ],
    );
  }

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final image = await picker.getImage(source: ImageSource.camera, maxWidth: 1080);
    if (image != null) {
      final imageFile = File(image.path);
      setState(() {
        _storedImage = imageFile;
      });
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = basename(imageFile.path);
      final savedImage = await imageFile.copy("${appDir.path}/$fileName");
      widget.onSelectImage(savedImage);
    }
  }
}
