import 'dart:convert';

import 'package:sica/models/gallerModel.dart';
import 'package:sica/utils/app_urls.dart';
import 'package:http/http.dart' as http;

import '../models/EventModel.dart';

class GalleryRepo {
  Future<List<GalleryModel>> getGalleryData(cat) async {
    List<GalleryModel> res = [];
    try {
      final queryParameters = {
        'db': 'sicadop_02',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        'category_id': '1'
      };
      var ur = Uri.parse("${AppConstants.baseURL}${AppConstants.galleryData}")
          .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(GalleryModel.fromJson(data));
          return res;
        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }
}
