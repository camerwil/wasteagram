import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewPostForm extends StatefulWidget {
  final pic;
  NewPostForm(this.pic);

  @override
  _NewPostFormState createState() => _NewPostFormState();
}

class _NewPostFormState extends State<NewPostForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Image(image: widget.pic),
            SizedBox(height: 40),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Enter Items Wasted'),
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 40),
            RaisedButton(
                child: Text('Post!'),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
