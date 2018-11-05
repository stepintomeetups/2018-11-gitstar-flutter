import 'package:flutter/material.dart';
import 'package:gitstar/entity.dart';

class RepoDetails extends StatefulWidget {

  final Repository repo;

  RepoDetails(this.repo);

  @override
  _RepoDetailsState createState() => _RepoDetailsState();

}

class _RepoDetailsState extends State<RepoDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.repo.fullName),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: IntrinsicHeight(
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(widget.repo.description ?? 'No description...'),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Icon(Icons.person),
                      ),
                      Text(widget.repo.owner.login)
                    ]
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Icon(Icons.star),
                      ),
                      Text(widget.repo.stars.toString())
                    ]
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Icon(Icons.watch),
                      ),
                      Text(widget.repo.watchers.toString())
                    ]
                  ),
                ),
                Center(
                  child: RaisedButton(
                    child: Icon(Icons.star_border),
                    onPressed: () {},
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}