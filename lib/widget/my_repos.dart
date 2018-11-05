import 'package:flutter/material.dart';

import 'package:gitstar/api.dart';
import 'package:gitstar/entity.dart';
import 'package:gitstar/widget/repo_details.dart';
import 'package:gitstar/widget/repo_list.dart';

class MyRepos extends StatefulWidget {

  final API api;

  MyRepos(this.api);

  @override
  _MyReposState createState() => _MyReposState();
  
}

class _MyReposState extends State<MyRepos> {

  @override
  Widget build(BuildContext context) {
    return RepoList(widget.api.getUsersRepositories(), (Repository repo) {
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (ctx) => RepoDetails(repo, widget.api)
        )
      );
    });
  }

}