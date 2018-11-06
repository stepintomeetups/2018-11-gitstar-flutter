import 'package:flutter/material.dart';
import 'package:gitstar/entity.dart';
import 'package:gitstar/api.dart';
import 'package:gitstar/ux.dart';

class RepoDetails extends StatefulWidget {

  final Repository repo;
  final API api;

  RepoDetails(this.repo, this.api);

  @override
  _RepoDetailsState createState() => _RepoDetailsState();

}

class _RepoDetailsState extends State<RepoDetails> {

  bool _starred;

  FutureBuilder _getStarButton() {
    return FutureBuilder(
      future: widget.api.isRepoStaredByMe(widget.repo.fullName),
      builder: (ctx, snapshot) {
        switch(snapshot.connectionState)  {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(GitStarColors.MAIN1)));
          case ConnectionState.done:
            _starred = snapshot.data;
            if (_starred) {
              return Center(
                child: RaisedButton(
                  child: Icon(Icons.star),
                  onPressed: () async {
                    await widget.api.unstarRepository(widget.repo.fullName);
                    setState(() { });
                  },
                )
              );
            } else {
              return Center(
                child: RaisedButton(
                  child: Icon(Icons.star_border),
                  onPressed: () async {
                    await widget.api.starRepository(widget.repo.fullName);
                    setState(() { });
                  },
                )
              );
            }
            return null;
          default:
        }
      },
    );
  }

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
            color: GitStarColors.MAIN2,
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
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: _getStarButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}