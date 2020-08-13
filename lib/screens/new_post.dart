import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/new_post_form.dart';

class NewPost extends StatelessWidget {
  static const routeName = 'newPost';
  @override
  Widget build(BuildContext context) {
    final pic = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("New Post"),
      ),
      body: NewPostForm(pic),
    );
  }
}
