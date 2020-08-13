import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wasteagram')),
      body: Center(child: CircularProgressIndicator()),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.camera_alt), onPressed: null),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
