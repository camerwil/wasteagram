import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/get_picture.dart';

class ListScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wasteagram')),
      body: Center(child: CircularProgressIndicator()),
      floatingActionButton: GetPicture(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
