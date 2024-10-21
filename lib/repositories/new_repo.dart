import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;

import '../models/NewsChannelheadline.dart';
import '../models/cetagories.dart';

class Repository {
  // Future<NewsChannelheadline> fetchchannelheadline() async {
  //   String str =
  //       'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=636ec7572b204ce3ae5bffd3d101e9d0';
  //   final response = await http.get(Uri.parse(str));
  //
  //   if (kDebugMode) {
  //     print(response.body);
  //   }
  //   if (response.statusCode == 200) {
  //     final body = jsonDecode(response.body);
  //     return NewsChannelheadline.fromJson(body);
  //   }
  //   throw Exception('Error');
  // }

  Future<NewsChannelheadline> fetchchannelheadline(String channelName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=636ec7572b204ce3ae5bffd3d101e9d0';

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelheadline.fromJson(body);
    }
    throw Exception('Error');
  }

  Future<Cetagories> fetcetagories(String cetagory) async {
    String url =
        'https://newsapi.org/v2/everything?q=${cetagory}&apiKey=636ec7572b204ce3ae5bffd3d101e9d0';

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return Cetagories.fromJson(body);
    }
    throw Exception('Error');
  }
}
