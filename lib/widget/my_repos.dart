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

  List<Repository> _repos = [];

  Widget _getListItem(Repository repo) {
    final gap = MediaQuery.of(context).size.width * .05;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: gap, vertical: gap / 2),
      child: ListTile(title: Text(repo.fullName)),
    );
  }

  ListView _getList(List<Repository> repos) {
    return ListView.builder(
      itemCount: repos.length,
      itemBuilder: (context, index) {
        final todo = repos[index];

        return GestureDetector(
          child: _getListItem(todo),
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (ctx) => RepoDetails(todo))
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final gap = MediaQuery.of(context).size.width * .05;

    final listFutureBuilder = FutureBuilder(
      future: widget.api.getUsersRepositories(),
      builder: (context, snapshot) {
        switch(snapshot.connectionState)  {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            _repos = snapshot.data;
            return Padding(
              padding: EdgeInsets.only(top: gap / 2),
              child: _getList(_repos),
            );
          default:
        }
      },
    );

    return RepoList(widget.api.getUsersRepositories(), (Repository repo) {
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (ctx) => RepoDetails(repo)
        )
      );
    });
  }

}