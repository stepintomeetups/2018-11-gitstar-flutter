import 'package:flutter/material.dart';
import 'package:gitstar/entity.dart';
import 'package:gitstar/api.dart';
import 'package:gitstar/widget/repo_list.dart';
import 'package:gitstar/widget/repo_details.dart';

class SearchRepos extends StatefulWidget {

  final API api;

  SearchRepos(this.api);

  _SearchReposState createState() => _SearchReposState();

}

class _SearchReposState extends State<SearchRepos> {

  final _searchController = TextEditingController();
  var query = '';

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
          onTap: () async {
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final gap = MediaQuery.of(context).size.width * .05;

    return Column(
      children: <Widget>[
        IntrinsicHeight(
          child: Card(
            margin: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _searchController,
                  ),
                  RaisedButton(
                    child: Text('Search...'),
                    onPressed: () {
                      setState(() {
                        query = _searchController.text;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(top: gap / 2),
            child: query.length > 0 ? RepoList(widget.api.searchRepositories(query), (Repository repo) {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (ctx) => RepoDetails(repo)
                )
              );
            }): null
          ),
        ),
      ],
    );
  }
}