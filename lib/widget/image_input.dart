import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;

class ImageInput extends StatefulWidget {
  final Function pointer;
  ImageInput(this.pointer);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final imageFile =
        await ImagePicker().getImage(source: ImageSource.camera, maxWidth: 600);
    if(imageFile==null){
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await sysPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile
        .path); // gives the path and name of image stored in memory temporarily
    final savedImage = await _storedImage.copy("${appDir.path}/$fileName");
    widget.pointer(savedImage);
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 200,
          height: 150,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                )
              : Text("No Image selected"),
          alignment: Alignment.center,
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            onPressed: _takePicture,
            label: Text("Take Picture"),
            textColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
