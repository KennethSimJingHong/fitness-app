import 'dart:io';
import 'package:fitness_app/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);
  final Function(File pickedImage) imagePickFn;
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  Future _pickImage() async{
    _pickedImage = null;
    final picker = ImagePicker();
    final pickImage = await picker.getImage(source: ImageSource.gallery, imageQuality: 50, maxWidth: 150,);
      if(pickImage != null){
        final pickedImageFile = File(pickImage.path);
        setState(() {
          _pickedImage = pickedImageFile;
        });
        widget.imagePickFn(pickedImageFile);
      }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        CircleAvatar(radius:40,
          backgroundImage: _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        FlatButton.icon(
          icon: Icon(Icons.image),
          label: Text("Add Image"),
          textColor: kDarkBlueColor,
          onPressed: _pickImage,
        ),
      ],
    );
  }
}