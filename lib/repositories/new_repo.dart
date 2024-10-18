import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;

import '../models/NewsChannelheadline.dart';

class Repository {
  Future<NewsChannelheadline> fetchchannelheadline() async {
    String str =
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=636ec7572b204ce3ae5bffd3d101e9d0';
    final response = await http.get(Uri.parse(str));

    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelheadline.fromJson(body);
    }
    throw Exception('Error');
  }
}
