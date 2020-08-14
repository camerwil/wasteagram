import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/widgets/get_picture.dart';
import 'package:wasteagram/models/post_information.dart';
import 'package:wasteagram/screens/detail_screen.dart';

class ListScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wasteagram')),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('posts')
            .orderBy("date", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data.documents != null &&
              snapshot.data.documents.length > 0) {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  PostInfo post = PostInfo();
                  post.fromDB(snapshot.data.documents[index]);
                  return ListTile(
                    leading: Text(post.itemCount.toString()),
                    title: Text(post.dateStr),
                    onTap: () => Navigator.pushNamed(
                        context, DetailScreen.routeName,
                        arguments: post),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: GetPicture(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
