import 'dart:convert';

import 'package:http/http.dart' as http;

import 'globals.dart';

class ApiServices {
  static Future<http.Response> addComicteca(
      String name, String email, String password) async {
    Map data = {
      "name": name,
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse('${baseURL}auth/register');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> getLatest() async {
    var url = Uri.parse('${baseURL}volumes/lastest');
    http.Response response = await http.get(url, headers: headers);
    print(response.body);
    return response;
  }
}

class VolumeBasic {
  final String coverImage;
  final int id;

  const VolumeBasic({required this.coverImage, required this.id});

  factory VolumeBasic.fromJson(Map<String, dynamic> json) {
    return VolumeBasic(id: json["id"], coverImage: json["coverImage"]);
  }
}
