// To parse this JSON data, do
//
//     final album = albumFromJson(jsonString);

import 'dart:convert';

List<Album> albumFromJson(String str) => List<Album>.from(json.decode(str).map((x) => Album.fromJson(x)));

String albumToJson(List<Album> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Album {
  Album({
    required this.id,
    required this.nodeId,
    required this.name,
    required this.htmlUrl,
    required this.description,
  });

  int id;
  String nodeId;
  String name;
  String htmlUrl;
  String description;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    id: json["id"],
    nodeId: json["node_id"],
    name: json["name"],
    htmlUrl: json["html_url"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "node_id": nodeId,
    "name": name,
    "html_url": htmlUrl,
    "description": description,
  };
}

