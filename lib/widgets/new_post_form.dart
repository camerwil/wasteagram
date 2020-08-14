import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/models/post_information.dart';

class NewPostForm extends StatefulWidget {
  final pic;
  NewPostForm(this.pic);

  @override
  _NewPostFormState createState() => _NewPostFormState();
}

class _NewPostFormState extends State<NewPostForm> {
  final _formKey = GlobalKey<FormState>();
  PostInfo formEntry = PostInfo();
  LocationData locationData;
  var locationService = Location();

  //Location retreival from document provided by instructor
  @override
  void initState() {
    super.initState();
    retreiveLocation();
  }

  void retreiveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service, Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location Service permission not granted. Returning.');
        }
      }
      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            FractionallySizedBox(
                alignment: Alignment.center,
                widthFactor: .8,
                child: Semantics(
                  image: true,
                  hint: 'Chosen Image of Wasted Food',
                  child: Image(image: FileImage(widget.pic)),
                )),
            SizedBox(height: 40),
            TextFormField(
                decoration:
                    const InputDecoration(hintText: 'Enter Items Wasted'),
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  formEntry.setItemCount(int.parse(value));
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a number of items!';
                  } else {
                    return null;
                  }
                }),
            SizedBox(height: 40),
            FractionallySizedBox(
              widthFactor: 1.0,
              child: RaisedButton(
                  child: Semantics(
                    button: true,
                    onTapHint: 'Upload Post',
                    child: Icon(
                      Icons.cloud_upload,
                      size: 100,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      formEntry.setDate();
                      formEntry.setLat(locationData.latitude);
                      formEntry.setLong(locationData.longitude);
                      StorageReference storageReference = FirebaseStorage
                          .instance
                          .ref()
                          .child(DateTime.now().toString());
                      StorageUploadTask uploadTask =
                          storageReference.putFile(widget.pic);
                      await uploadTask.onComplete;
                      formEntry
                          .setPhotoURL(await storageReference.getDownloadURL());
                      Firestore.instance.collection('posts').add({
                        'date': formEntry.dateRaw,
                        'photoURL': formEntry.photoURL,
                        'itemCount': formEntry.itemCount,
                        'lat': formEntry.lat,
                        'long': formEntry.long
                      });

                      Navigator.pop(context);
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
