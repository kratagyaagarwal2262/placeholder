import 'dart:convert';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:placeholder/users/user.dart';
import 'package:http/http.dart' as http;


List<Album> request(String responseBody)
{
  var list = jsonDecode(responseBody) as List<dynamic>;
  List<Album> album = list.map((model) => Album.fromJson(model)).toList();
  return album;
}

Future <List<Album>> fetchData() async
{
  final response = await http
      .get(Uri.parse('https://api.github.com/users/JakeWharton/repos?page=1&per_page=15'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return compute(request , response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}