class Token {
  String token;

  Token({required this.token});

  Token.fromJson(Map<String, dynamic> json)
      : token = json['token'] as String;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}
