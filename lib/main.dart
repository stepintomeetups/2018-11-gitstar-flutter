import 'package:flutter/material.dart';
import 'package:gitstar/api.dart';
import 'package:gitstar/widget/tab_controller.dart';
import 'package:gitstar/widget/login.dart';
import 'package:gitstar/ux.dart';

final api = API();

void main() => runApp(GitStar());

class GitStar extends StatelessWidget {

  final routes = {
    '/home': (ctx) => GitStarTabController(api),
    '/': (ctx) => Login(api)
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: GitStarColors.MAIN1
      ),
      routes: routes,
    );
  }
}