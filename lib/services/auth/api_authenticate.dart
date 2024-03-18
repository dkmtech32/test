import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_app/model/token/access_token.dart';

class ApiProvider {
  Future<String> authenticate(String uid, String email) async {
    final url = Uri.https('sportscape.onrender.com', 'api/v1/auth/google-auth');
    final body = {"username": uid, "email": email};
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      final parse = json.decode(response.body);
      final String token = Token.fromJson(parse).token;
      return token;
    } else {
      throw Exception("Invalid username or password");
    }
  }
}
