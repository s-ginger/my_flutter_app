import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:my_notesflutter/repository/repository.dart';

class AuthRepository implements IAuthRepository {
  final client = HttpClient();
  String? _token;
  String? _username;

  @override
  String? get token => _token;

  @override
  String? get username => _username;

  @override
  Future<bool> register({
    required String username,
    required String password,
  }) async {
    try {
      final request = await client.postUrl(
        Uri.parse("http://10.0.2.2:8080/register"),
      );

      request.headers.contentType = ContentType.json;

      request.write(jsonEncode({"username": username, "password": password}));

      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();
      final Map<String, dynamic> json = jsonDecode(body);

      if (json["ok"] == true) {
        _username = username;
      }
      return json["ok"] == true;
    } catch (e) {
      debugPrint("Error registration $e");
      return false;
    }
  }

  @override
  Future<bool> login({
    required String username,
    required String password
  }) async {
    try {
      final request = await client.postUrl(
        Uri.parse("http://10.0.2.2:8080/login"),
      );

      request.headers.contentType = ContentType.json;

      request.write(jsonEncode({"username" : username, "password" : password}));

      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();
      final Map<String, dynamic> json = jsonDecode(body);

      if (json["ok"] == true) {
        _username = username;
        _token = json["token"];
      }
      return json["ok"] == true;
    } catch (e) {
      debugPrint("Error login $e");
      return false;
    }
  }


}
