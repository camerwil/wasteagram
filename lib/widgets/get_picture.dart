import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/screens/new_post.dart';

class GetPicture extends StatefulWidget {
  @override
  _GetPictureState createState() => _GetPictureState();
}

class _GetPictureState extends State<GetPicture> {
  var _picture;

  final picker = ImagePicker();

  Future getPicCamera() async {
    Navigator.pop(context);
    final pickedPicture = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedPicture == null) {
        return;
      } else {
        _picture = File(pickedPicture.path);
        Navigator.pushNamed(context, NewPost.routeName, arguments: _picture);
      }
    });
  }

  Future getPicGallery() async {
    Navigator.pop(context);
    final pickedPicture = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedPicture == null) {
        return;
      } else {
        _picture = File(pickedPicture.path);
        Navigator.pushNamed(context, NewPost.routeName, arguments: _picture);
      }
    });
  }

  void showPictureOptions(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: [
                ListTile(
                  title: Text('Choose where to get your image:'),
                ),
                Semantics(
                  button: true,
                  onTapHint: 'Use Camera',
                  child: ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('Camera'),
                    onTap: () => {getPicCamera()},
                  ),
                ),
                Semantics(
                  button: true,
                  onTapHint: "Use Gallery",
                  child: ListTile(
                    leading: Icon(Icons.image),
                    title: Text('Gallery'),
                    onTap: () => {getPicGallery()},
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Semantics(
          button: true,
          onTapHint: 'Pick a Photo',
          child: Icon(Icons.camera_alt),
        ),
        onPressed: () {
          showPictureOptions(context);
        });
  }
}
