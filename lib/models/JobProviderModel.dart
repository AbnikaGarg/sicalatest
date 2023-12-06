class JobProviderModel {
  JobProviderModel({
      this.jobProviderDetails,});

  JobProviderModel.fromJson(dynamic json) {
    if (json['job_provider_details'] != null) {
      jobProviderDetails = [];
      json['job_provider_details'].forEach((v) {
        jobProviderDetails?.add(JobProviderDetails.fromJson(v));
      });
    }
  }
  List<JobProviderDetails>? jobProviderDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (jobProviderDetails != null) {
      map['job_provider_details'] = jobProviderDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class JobProviderDetails {
  JobProviderDetails({
      this.designation, 
      this.jobsProvider,});

  JobProviderDetails.fromJson(dynamic json) {
    designation = json['designation'];
    jobsProvider = json['jobs_provider'] != null ? JobsProvider.fromJson(json['jobs_provider']) : null;
  }
  String? designation;
  JobsProvider? jobsProvider;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['designation'] = designation;
    if (jobsProvider != null) {
      map['jobs_provider'] = jobsProvider?.toJson();
    }
    return map;
  }

}

class JobsProvider {
  JobsProvider({
      this.mobileNumber, 
      this.membershipNo, 
      this.memberId, 
      this.skill, 
      this.experience, 
      this.portifolioLink, 
      this.designation, 
      this.memberName, 
      this.projectRequirement, 
      this.medium, 
      this.note,});

  JobsProvider.fromJson(dynamic json) {
    mobileNumber = json['mobile_number'].toString();
    membershipNo = json['membership_no'];
    memberId = json['member_id'];
    skill = json['skill'].toString();
    experience = json['experience'];
    portifolioLink = json['portifolio_link'];
    designation = json['designation'];
    memberName = json['member_name'];
    projectRequirement = json['project_requirement'];
    medium = json['medium'];
    note = json['note'].toString();
  }
  String? mobileNumber;
  String? membershipNo;
  int? memberId;
  String? skill;
  String? experience;
  String? portifolioLink;
  String? designation;
  String? memberName;
  String? projectRequirement;
  String? medium;
  String? note;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile_number'] = mobileNumber;
    map['membership_no'] = membershipNo;
    map['member_id'] = memberId;
    map['skill'] = skill;
    map['experience'] = experience;
    map['portifolio_link'] = portifolioLink;
    map['designation'] = designation;
    map['member_name'] = memberName;
    map['project_requirement'] = projectRequirement;
    map['medium'] = medium;
    map['note'] = note;
    return map;
  }

}