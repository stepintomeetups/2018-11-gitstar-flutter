import 'package:flutter/material.dart';
import 'package:gitstar/entity.dart';
import 'package:gitstar/api.dart';
import 'package:gitstar/widget/repo_list.dart';
import 'package:gitstar/widget/repo_details.dart';
import 'package:gitstar/ux.dart';

class SearchRepos extends StatefulWidget {

  final API api;

  SearchRepos(this.api);

  _SearchReposState createState() => _SearchReposState();

}

class _SearchReposState extends State<SearchRepos> {

  final _searchController = TextEditingController();
  var query = '';

  @override
  Widget build(BuildContext context) {
    final gap = MediaQuery.of(context).size.width * .05;

    return Column(
      children: <Widget>[
        IntrinsicHeight(
          child: Card(
            color: GitStarColors.MAIN2,
            margin: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    cursorColor: GitStarColors.MAIN1,
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
                  builder: (ctx) => RepoDetails(repo, widget.api)
                )
              );
            }): null
          ),
        ),
      ],
    );
  }
}