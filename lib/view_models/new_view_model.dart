import 'package:flutter/material.dart';
import 'package:newsapp/models/NewsChannelheadline.dart';
import 'package:newsapp/repositories/new_repo.dart';

import '../models/cetagories.dart';

class NewViewModel {
  final _rep = Repository();
  Future<NewsChannelheadline> fetchchannelheadline(String channelName) async {
    final response = await _rep.fetchchannelheadline(channelName);
    return response;
  }

  Future<Cetagories> fetcetagories(String cetagory) async {
    final response = await _rep.fetcetagories(cetagory);
    return response;
  }
}
