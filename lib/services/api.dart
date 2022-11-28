import 'dart:convert';

import 'package:http/http.dart' as http;

import 'globals.dart';

class ApiServices {
  static Future<http.Response> addComicteca(int user_id, int volume_id) async {
    Map data = {
      "user_id": user_id,
      "volume_id": volume_id,
    };
    var body = json.encode(data);
    var url = Uri.parse('${baseURL}comicteca');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    return response;
  }

  static Future<http.Response> getLatest() async {
    var url = Uri.parse('${baseURL}volumes/lastest');
    http.Response response = await http.get(url, headers: headers);
    return response;
  }

  static Future<http.Response> getPopular() async {
    var url = Uri.parse('${baseURL}volumes/popular');
    http.Response response = await http.get(url, headers: headers);
    return response;
  }

  static Future<http.Response> getComicteca(int id) async {
    var url = Uri.parse('${baseURL}comicteca/$id');
    http.Response response = await http.get(url, headers: headers);
    return response;
  }

  static Future<http.Response> checkAdded(int id, int volume_id) async {
    var url =
        Uri.parse('${baseURL}comicteca/alreadyThere/$id?volume_id=$volume_id');
    http.Response response = await http.get(url, headers: headers);
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

class Edition {
  final int id;
  final String title;
  final String publisher;
  final String language;
  final String format;
  final int isStandalone;
  final int isClosed;
  final String description;
  final int ratingAvg;
  final String createdAt;
  final String updatedAt;

  const Edition(
      {required this.id,
      required this.title,
      required this.publisher,
      required this.language,
      required this.format,
      required this.isStandalone,
      required this.isClosed,
      required this.description,
      required this.ratingAvg,
      required this.createdAt,
      required this.updatedAt});

  factory Edition.fromJson(Map<String, dynamic> json) {
    return Edition(
        id: json['id'] ?? 0,
        title: json['title'] ?? "Default",
        publisher: json['publisher'] ?? "Default",
        language: json['language'] ?? "Default",
        format: json['format'] ?? "Default",
        isStandalone: json['isStandalone'] ?? 0,
        isClosed: json['isClosed'] ?? 0,
        description: json['description'] ?? "Default",
        ratingAvg: json['ratingAvg'] ?? 0,
        createdAt: json['created_at'] ?? "Default",
        updatedAt: json['updated_at'] ?? "Default");
  }
}

class VolumeFull {
  final String? coverImage;
  final int id;
  final String? title;
  final int number;
  final String? ISBN;
  final String? argument;
  final int editionId;
  final String? createdAt;
  final String? updatedAt;

  final Edition? edition;

  const VolumeFull(
      {this.title,
      required this.number,
      this.ISBN,
      this.argument,
      required this.editionId,
      this.createdAt,
      this.updatedAt,
      this.edition,
      this.coverImage,
      required this.id});

  factory VolumeFull.fromJson(Map<String, dynamic> json) {
    return VolumeFull(
        id: json['id'] ?? 0,
        coverImage: json['coverImage'] ?? "Default",
        createdAt: json['created_at'] ?? "Default",
        updatedAt: json['updated_at'] ?? "Default",
        argument: json['argument'] ?? "Default",
        number: json['number'] ?? 0,
        ISBN: json['ISBN'] ?? "Default",
        title: json['title'] ?? "Default",
        editionId: json['edition_id'] ?? 0,
        edition: json['edition'] ??
            const Edition(
                id: 0,
                title: "title",
                publisher: "publisher",
                language: "language",
                format: "format",
                isStandalone: 0,
                isClosed: 0,
                description: "description",
                ratingAvg: 0,
                createdAt: "createdAt",
                updatedAt: "updatedAt"));
  }
}

class Comicteca {
  final int id;
  final int volumesOwned;
  final String title;
  final int totalVolumes;
  final List<VolumeFull> volumesLeft;
  final String coverImage;

  const Comicteca(
      {required this.id,
      required this.volumesOwned,
      required this.title,
      required this.totalVolumes,
      required this.volumesLeft,
      required this.coverImage});

  factory Comicteca.fromJson(Map<String, dynamic> json) {
    return Comicteca(
        id: json['id'],
        volumesOwned: json['volumesOwned'],
        title: json['title'],
        totalVolumes: json['totalVolumes'],
        volumesLeft: json['volumesLeft'],
        coverImage: json['coverImage']);
  }
}
