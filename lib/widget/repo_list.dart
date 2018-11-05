import 'package:flutter/material.dart';

import 'package:gitstar/entity.dart';

class RepoList extends StatefulWidget {

  final Future<List<Repository>> repoListFuture;
  final Function itemSelectCallback;

  RepoList(this.repoListFuture, this.itemSelectCallback);

  _RepoListState createState() => _RepoListState();

}

class _RepoListState extends State<RepoList> {

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
            widget.itemSelectCallback(todo);
          } 
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final gap = MediaQuery.of(context).size.width * .05;

    return FutureBuilder(
      future: widget.repoListFuture,
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
  }

}