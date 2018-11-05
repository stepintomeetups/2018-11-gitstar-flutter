import 'package:flutter/material.dart';
import 'package:gitstar/api.dart';
import 'package:gitstar/widget/tab_controller.dart';
import 'package:gitstar/widget/login.dart';
import 'package:gitstar/widget/repo_details.dart';
import 'package:gitstar/entity.dart';

final api = API();

void main() => runApp(GitStar());

class GitStar extends StatelessWidget {

  final routes = {
    '/home': (ctx) => GitStarTabController(api),
    '/': (ctx) => Login(api)
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
    );
  }
}