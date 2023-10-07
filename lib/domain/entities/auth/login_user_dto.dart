class LoginUserDto {
  final String token;
  final int id;
  final String username;
  final String firstname;
  final String lastname;
  final int score;
  final String avatarUrl;

  LoginUserDto(
      {required this.token,
      required this.id,
      required this.username,
      required this.firstname,
      required this.lastname,
      required this.score,
      required this.avatarUrl});

  factory LoginUserDto.fromJson(Map<String, dynamic> json) {
    return LoginUserDto(
      token: json["token"].toString(),
      id: json["id"].toInt(),
      username: json["username"].toString(),
      firstname: json["firstname"].toString(),
      lastname: json["lastname"].toString(),
      score: json["score"].toInt() ?? 0,
      avatarUrl: json["avatar"].toString() ?? "",
    );
  }

  
}
