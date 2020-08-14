import 'package:flutter/material.dart';
import 'package:wasteagram/models/post_information.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = 'DetailScreen';

  @override
  Widget build(BuildContext context) {
    final PostInfo post = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Wasteagram')),
      body: ListView(
        children: [
          Center(
              child: Text(post.dateStr,
                  style: Theme.of(context).textTheme.headline5)),
          FractionallySizedBox(
              alignment: Alignment.center,
              widthFactor: .8,
              child: Semantics(
                image: true,
                hint: 'Wasted Food',
                child: Image.network(post.photoURL),
              )),
          SizedBox(height: 40),
          Center(
            child: Text('Wasted items: ${post.itemCount}',
                style: Theme.of(context).textTheme.subtitle1),
          ),
          SizedBox(height: 40),
          Center(child: Text('Location: (${post.lat}, ${post.long})'))
        ],
      ),
    );
  }
}
