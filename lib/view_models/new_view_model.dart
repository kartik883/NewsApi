import 'package:flutter/material.dart';
import 'package:newsapp/models/NewsChannelheadline.dart';
import 'package:newsapp/repositories/new_repo.dart';

class NewViewModel {
  final _rep = Repository();
  Future<NewsChannelheadline> fetchchannelheadline() async {
    final response = await _rep.fetchchannelheadline();
    return response;
  }
}
