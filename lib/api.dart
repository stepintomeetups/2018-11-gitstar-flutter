import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:gitstar/entity.dart';

class API {

  String accessToken;

  loginWithCode(String code) async {
    var res = await http.post("https://github.com/login/oauth/access_token", body: {
      "client_id": "b8ed659f28e36384792d",
      "client_secret": "f49fb84e1c4d7dadb256e55653e1cbc67fe65816",
      "code": code
    });

    accessToken = res.body.split("&")[0].split("=")[1];
  }

  Future<List<Repository>> getUsersRepositories() async {
    var res = await http.get("https://api.github.com/user/repos?access_token=$accessToken");
    List<dynamic> jsonBody = json.decode(res.body);
    List<Repository> repos = jsonBody.map((json) => Repository.fromJSON(json)).toList();
    return repos;
  }

  Future<List<Repository>> searchRepositories(String q) async {
    var res = await http.get("https://api.github.com/search/repositories?q=$q&access_token=$accessToken");
    Map<String, dynamic> jsonBody = json.decode(res.body);
    List<Repository> repos = jsonBody["items"].map<Repository>((json) => Repository.fromJSON(json)).toList();
    return repos;
  }

  starRepository(String fullName) async {
    return await http.put("https://api.github.com/user/starred/$fullName?access_token=$accessToken");
  }

}