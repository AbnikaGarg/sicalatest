import 'dart:convert';
import 'dart:isolate';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/models/DopApprovalModel.dart';
import 'package:sica/models/DopModel.dart';
import 'package:sica/models/JobProviderModel.dart';
import 'package:sica/models/MemberDetailModel.dart';
import 'package:sica/models/OtherMemberProfile.dart';
import 'package:sica/models/PaymentResponse.dart';
import 'package:sica/models/ShootingModel.dart';
import 'package:sica/utils/app_urls.dart';
import 'package:http/http.dart' as http;
import 'package:sica/views/shooting/add_associate.dart';

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
        'offset': "$page",
        'limit': "100"
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

  Future<List<OtherMemberProfile>> getAllMemberData() async {
    List<OtherMemberProfile> res = [];
    try {
      final queryParameters = {
        'db': 'odoo_si',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        'offset': "0",
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

  Future<List> addAssociate(
    String shootingid,
    String name,
    String memberno,
    String mobile,
  ) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.createAssociate}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&shooting_id=$shootingid&data={'name': '$name', 'mobile_number': '$mobile', 'member_number': '$memberno'}");
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
      String notes,
      String portfiliolink) async {
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
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
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

  Future<List> submitShooting(
      String mobile,
      String name,
      String memberNo,
      String designation,
      String projectName,
      String medium,
      String startdate,
      String endDate,
      String notes,
      String approvalstatus) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.createShooting}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={ 'mobile_number': '$mobile' , 'member_name': '$name' , 'member_number':'$memberNo' , 'designation':'$designation' , 'project_title': '$projectName' , 'medium_id': '$medium' , 'start_date': '$startdate' , 'end_date': '$endDate' , 'notes': '$notes' , 'choose_dop_for_approval': '$approvalstatus'}");
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

  Future<List> submitDop(
      int shootingid,
      String mobile,
      String name,
      String memberNo,
      String designation,
      String projectName,
      String medium,
      String startdate,
      String endDate,
      String outdoorlink,
      List associates) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      // final queryParameters = {
      //   'db': 'odoo_si',
      //   'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
      //   'MEMBERSHIP_ID': "$memberid",
      //   'data':
      //       "{'shooting_id': 5,'mobile_number': '$mobile', 'member_name': '$name', 'member_number': '$memberNo', 'designation': '$designation', 'project_title': '$projectName', 'medium_id': '$medium', 'start_date': '$startdate', 'end_date': '$endDate', 'outdoor_link_details': '$outdoorlink', 'no_of_associate' : ${associates.length}, 'associate': '$associates'}"
      // };
      List array = [];
      for (int i = 0; i < associates.length; i++) {
        var json = {
          'name': '${associates[i]["name"]}',
          'mobile_number': '${associates[i]["mobile_number"]}',
          'member_number': '${associates[i]["member_number"]}',
        };
        array.add(jsonEncode(json));
      }
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.createDop}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'shooting_id':$shootingid,'mobile_number': '$mobile', 'member_name': '$name', 'member_number': '$memberNo', 'designation': '$designation', 'project_title': '$projectName', 'medium_id': '$medium', 'start_date': '$startdate', 'end_date': '$endDate', 'outdoor_link_details': '$outdoorlink', 'no_of_associate' :${associates.length},'associate': $array}");
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

  Future<List> getMediumService() async {
    List res = [];
    try {
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.medium}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261");
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(data["medium_details"]);
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List<DopModel>> getDops(int page) async {
    List<DopModel> res = [];
    try {
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.getShootingdop}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&offset=0&limit=10");
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(DopModel.fromJson(data));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List<ShootingModel>> getShootings() async {
    List<ShootingModel> res = [];
    try {
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.getShooting}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261");
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(ShootingModel.fromJson(data));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List<DopApprovalModel>> getApprovalService() async {
    List<DopApprovalModel> res = [];
    try {
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.getApproval}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261");
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(DopApprovalModel.fromJson(data));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List> getBannerImages() async {
    List res = [];
    try {
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.getBanners}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261");
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.body);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(data["photo"]);
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List> getReasons() async {
    List res = [];
    try {
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.getReasons}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261");
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(data["grievance_reason_details"]);
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List> createReason(
      String reasonid,
      String memberNo,
      String name,
      String projectName,
      String productionHouse,
      String outdoorUnit,
      String location,
      String issueType,
      String approx,
      String managerContact,
      String solveIssue,
      String reportedIssue,
      String productionContact,
      String briefIssue) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.createGrievance}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&Reason_id=$reasonid&data={'member_name_no': '$memberNo', 'name': '$name', 'project_name': '$projectName', 'projection_house_name': '$productionHouse', 'outdoor_unit_name': '$outdoorUnit', 'location': '$location', 'contact_outdoor_unit_manager': '$managerContact', 'approximate_time_lost': '$approx', 'has_outdoor_unit_manager_helpful_to_the_solve_issue': '$solveIssue', 'name_contact_no_of_production_manager_executive_producer': '$productionContact', 'brief_issue_faced_with_service_of_outdoor_unit_equipment': '$briefIssue', 'issue_has_been_reported': '$reportedIssue', 'issue_type': '$issueType'}");
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


Future<List> updateApprovalService(String shooting_dop_id, String associate_id,
    bool attending, String reason) async {
  List userResponse = [];
  try {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var memberid = (sharedPreferences.getString('memberid') ?? "");
    var ur = Uri.parse(
        "${AppConstants.baseURL}${AppConstants.updateApproval}?db=odoo_si&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'shooting_dop_id': '$shooting_dop_id', 'associate_id': $associate_id, 'attending': '$attending', 'reason': '$reason'}");
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
}}
