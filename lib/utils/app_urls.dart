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
}
