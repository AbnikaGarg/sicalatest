import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/models/JobProviderModel.dart';
import 'package:sica/models/MemberDetailModel.dart';
import 'package:sica/models/OtherMemberProfile.dart';
import 'package:sica/models/PaymentResponse.dart';
import 'package:sica/models/TopicModel.dart';
import 'package:sica/utils/app_urls.dart';
import 'package:http/http.dart' as http;

class Forum {
  Future<List> getForumCat() async {
    List res = [];
    try {
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.getCategories}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261");
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(data["discuss_category_details"]);
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List<TopicModel>> getTopicList(catid) async {
    List<TopicModel> res = [];
    try {
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.discussionTopic}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&category_id=$catid&offset=0&limit=20");
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
    //  print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          //final data = jsonDecode(response.body);
          res.add(TopicModel.fromJson(jsonDecode(response.body)));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }
Future<List> createCommment(String comment, int discussionid) async {
    List res = [];
    try {
       SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.createComment}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'comment': '$comment'}&DISCUSSION_ID=$discussionid");
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          //final data = jsonDecode(response.body);
          res.add(jsonDecode(response.body));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }
  Future<List> addTopic(String topic, String id) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.createTopic}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'discussion_topic': '$topic', 'category_id': '$id'}");
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.body);
      switch (response.statusCode) {
        case 200:
          userResponse.add(jsonDecode(response.body));
          return userResponse;

        default:
          return userResponse;
      }
    } catch (e) {
      return userResponse;
    }
  }
  Future<List> editTopic(String topic, String id) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.updateTopic}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'topic': '$topic'}&DISCUSSION_ID=$id");
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.body);
      switch (response.statusCode) {
        case 200:
          userResponse.add(jsonDecode(response.body));
          return userResponse;

        default:
          return userResponse;
      }
    } catch (e) {
      return userResponse;
    }
  }
  Future<List> deleteTopic(String topic, String id) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.deleteTopic}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'topic': '$topic'}&DISCUSSION_ID=$id");
      final response = await http.delete(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.body);
      switch (response.statusCode) {
        case 200:
          userResponse.add(jsonDecode(response.body));
          return userResponse;

        default:
          return userResponse;
      }
    } catch (e) {
      return userResponse;
    }
  }
}
