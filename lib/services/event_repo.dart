import 'dart:convert';

import 'package:sica/utils/app_urls.dart';
import 'package:http/http.dart' as http;

import '../models/EventModel.dart';

class Eventrepo {
  Future<List<EventModel>> getEvents(cat) async {
    List<EventModel> res = [];
    var ur;
    try {
      final queryParameters = {
        'db': 'sicadop_02',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        'category_id':cat==1?"1": '$cat'
      };
      if (cat == 1) {
        ur = Uri.parse(
                "${AppConstants.baseURL}${AppConstants.getEvents}")
            .replace(queryParameters: queryParameters);
      } else {
        ur = Uri.parse("${AppConstants.baseURL}${AppConstants.getEventsCategory}")
            .replace(queryParameters: queryParameters);
      }
      final response = await http.get(ur);
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          res.add(EventModel.fromJson(jsonDecode(response.body)));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List> getCategory() async {
    List res = [];
    try {
      var ur = Uri.parse("${AppConstants.baseURL}${AppConstants.getCategory}");
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.body);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(data["event_category_details"]);
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }
}
