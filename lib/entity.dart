class User {
  final String login;

  User(this.login);

  User.fromJSON(Map<String, dynamic> json)
    : login = json['login'];
}

class Repository {
  final String fullName;
  final User owner;
  final String description;
  final String language;
  final int stars;
  final int watchers;
  final double score;

  Repository(
    this.fullName,
    this.owner,
    this.description,
    this.language,
    this.stars,
    this.watchers,
    this.score
  );

  Repository.fromJSON(Map<String, dynamic> json)
    : fullName = json['full_name'],
      owner = User.fromJSON(json['owner']),
      description = json['description'],
      language = json['language'],
      stars = json['stargazers_count'],
      watchers = json['watchers_count'],
      score = json['score'];
}