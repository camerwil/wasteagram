import 'package:flutter/material.dart';
import 'screens/detail_screen.dart';
import 'screens/new_post.dart';
import 'screens/list_screen.dart';

class App extends StatelessWidget {
  final String title;
  static final routes = {
    ListScreen.routeName: (context) => ListScreen(),
    NewPost.routeName: (context) => NewPost(),
    DetailScreen.routeName: (context) => DetailScreen()
  };

  const App({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData.dark(),
      routes: App.routes,
    );
  }
}
