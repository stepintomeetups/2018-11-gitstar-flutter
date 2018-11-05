import 'package:flutter/material.dart';
import 'package:gitstar/widget/my_repos.dart';
import 'package:gitstar/widget/search_repos.dart';
import 'package:gitstar/api.dart';

class GitStarTabController extends StatelessWidget {

  final API api;

  GitStarTabController(this.api);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person)),
              Tab(icon: Icon(Icons.search))
            ]
          ),
          title: Text('GitStar'),
        ),
        body: TabBarView(
          children: [
            MyRepos(api),
            SearchRepos(api),
          ],
        ),
      ),
    );
  }
}