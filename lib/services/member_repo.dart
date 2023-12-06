import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/models/JobProviderModel.dart';
import 'package:sica/models/MemberDetailModel.dart';
import 'package:sica/models/OtherMemberProfile.dart';
import 'package:sica/models/PaymentResponse.dart';
import 'package:sica/utils/app_urls.dart';
import 'package:http/http.dart' as http;

class MemberRepo {
  Future<List<MemberDetailModel>> getMemberDetails() async {
    List<MemberDetailModel> res = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      final queryParameters = {
        'db': 'odoo_si',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        'MEMBERSHIP_ID': memberid,
      };
      var ur = Uri.parse("${AppConstants.baseURL}${AppConstants.memberDetails}")
          .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          res.add(MemberDetailModel.fromJson(jsonDecode(response.body)));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List<OtherMemberProfile>> getAllMemberDetails(page) async {
    List<OtherMemberProfile> res = [];
    try {
      final queryParameters = {
        'db': 'odoo_si',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        'offset': "1",
        'limit': "10000"
      };
      var ur = Uri.parse("${AppConstants.baseURL}${AppConstants.getallMember}")
          .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          res.add(OtherMemberProfile.fromJson(jsonDecode(response.body)));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List> addSocialLinks(String facebook, String insta, String youtube,
      String twiter, String linkedin) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.socialLinks}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'facebook_link':'$facebook','youtube_link':'$youtube','linkedin_link':'$linkedin','twitter_link':'$twiter','instagram_link':'$insta'}");
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
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

  Future<List> updateMembers(
      String mobile,
      String name,
      String memberNo,
      String designation,
      String skills,
      String medium,
      String exp,
      String link,
      String notes) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.updateMember}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'member_name': '$name', 'mobile_number': '$mobile', 'membership_no': '$memberNo', 'skills': '$skills', 'designation': '$designation', 'medium': '$medium', 'experience': '$exp', 'portifolio_link': '$link', 'notes': '$notes', 'profile_image': ''}");
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
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

  Future<List> submitJobSeeker(
      String mobile,
      String name,
      String memberNo,
      String designation,
      String skills,
      String skill_2,
      String postApply,
      String available_date,
      String exp,
      String link,
      String notes,
      String path) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.createJobSeeker}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'membership_no':'$memberNo','mobile_number':'$mobile','designation':'$designation','member_name':'$name','skill_1':'$skills','skill_2':'$skill_2','post_applying':'$postApply','experience':'$exp','portifolio_link':'$link','note':'$notes','document_binary':'$path','available_date':'$available_date'}");
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
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

  Future<List> addWork(
    String name,
    String year,
    String designation,
  ) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.createProject}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'project_name': '$name', 'year': '$year', 'designation': '$designation'}");
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
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

  Future<List> editWork(
      String name, String year, String designation, int id) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.updateProject}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'project_name': '$name', 'year': '$year', 'designation': '$designation'}&ID=$id");
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
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

  Future<List> deleteWork(
      String name, String year, String designation, int id) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.deleteProject}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'project_name': '$name', 'year': '$year', 'designation': '$designation'}&ID=$id");
      final response = await http.delete(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
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

  Future<List<JobProviderModel>> getJobProviders() async {
    List<JobProviderModel> res = [];
    try {
      final queryParameters = {
        'db': 'odoo_si',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261'
      };
      var ur =
          Uri.parse("${AppConstants.baseURL}${AppConstants.getJobProvider}")
              .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          res.add(JobProviderModel.fromJson(jsonDecode(response.body)));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List> submitJobProvider(
      String mobile,
      String name,
      String memberNo,
      String designation,
      String skills,
      String medium,
      String exp,
      String projectreq,
      String notes, String portfiliolink) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.addJobProvider}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'membership_no': '$memberNo', 'mobile_number': '$mobile', 'designation': '$designation', 'member_name': '$name', 'skill': '$skills', 'experience': '$exp', 'portifolio_link': '$portfiliolink', 'note': '$notes', 'document_binary': '', 'project_requirement': '$projectreq', 'medium': '$medium'}");
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
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
  Future<List<PaymentResponse>> createPayment() async {
    List<PaymentResponse> res = [];
    SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
     var memberid = (sharedPreferences.getString('memberid') ?? "");
    try {
      final queryParameters = {
        'db': 'odoo_si',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        'MEMBERSHIP_ID': "$memberid"
      };
      var ur = Uri.parse("${AppConstants.baseURL}${AppConstants.createPayment}")
          .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          res.add(PaymentResponse.fromJson(jsonDecode(response.body)));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }
}
