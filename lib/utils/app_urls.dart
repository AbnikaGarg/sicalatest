class AppConstants {
  static var noInternetMsg = "Application requires network to proceed";

  static String baseURL = "http://68.178.168.28:8069";
  static String verifyOtp = "/otp/verify";
  static String login = "/api/get_login_otp";
  static String memberDetails = "/get/member_details";
  static String socialLinks = "/post/member_social_links";
  static String updateMember = "/post/member_details";
  static String createProject = "/create/work_details";
  static String updateProject = "/update/work_details";
  static String deleteProject = "/delete/work_details";
  static String getallMember = "/get/all/member_details";
  static String createJobSeeker = "/create/job_seeker";
  static String getJobProvider = "/all/job_provider";
  static String addJobProvider = "/create/job_provider";
  static String createPayment = "/create/razorpay_order";
  static String getCategories = "/get/all/discuss_category";
  static String discussionTopic = "/get/all/discussion_topic";
  static String createTopic = "/create/discussion_topic";
  static String updateTopic = "/update/discussion_topic";
  static String deleteTopic = "/delete/discussion_topic";
  static String createComment = "/create/discussion_comment";
  static String createShooting = "/create/sica_shooting";
  static String createDop = "/create/shooting_dop";
  static String getShootingdop = "/get/all/shooting_dop_details";
  static String getShooting = "/get/all/shooting_details";
  static String medium = "/get/all/medium";
  static String getBanners = "/get/mobile_photo";
  static String getReasons = "/get/all/grievance_reason";
  static String createGrievance = "/create/grievance_report";
  static String createAssociate = "/create/shooting_associate";
  static String getApproval = "/get/all/shooting_dop_approval";
  static String updateApproval = "/update/dop_associate_attending";
}
