import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gitstar/api.dart';

class Login extends StatelessWidget {

  final API api;

  static const platform = const MethodChannel('viktor.simko.gitstar/auth');

  Login(this.api);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          color: Colors.blue,
          child: Padding(
            padding: EdgeInsets.only(left: 40.0, right: 40.0, bottom: 10.0, top: 10.0),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Icon(Icons.star, size: 100.0, color: Colors.white),
                  RaisedButton(
                    child: Text('Login with GitHub'),
                    onPressed: () async {
                      String token = await platform.invokeMethod('doGitHubAuth');
                      await api.loginWithCode(token);
                      Navigator.of(context).pushNamed('/home');
                    },
                  )
                ]
              )
            )
          )
        )
      )
    );
  }

}