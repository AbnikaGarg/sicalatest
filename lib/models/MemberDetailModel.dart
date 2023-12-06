class MemberDetailModel {
  MemberDetailModel({
      this.memberBasicDetails, 
      this.projectWork,});

  MemberDetailModel.fromJson(dynamic json) {
    memberBasicDetails = json['member_basic_details'] != null ? MemberBasicDetails.fromJson(json['member_basic_details']) : null;
    if (json['project_work'] != null) {
      projectWork = [];
      json['project_work'].forEach((v) {
        projectWork?.add(ProjectWork.fromJson(v));
      });
    }
  }
  MemberBasicDetails? memberBasicDetails;
  List<ProjectWork>? projectWork;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (memberBasicDetails != null) {
      map['member_basic_details'] = memberBasicDetails?.toJson();
    }
    if (projectWork != null) {
      map['project_work'] = projectWork?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ProjectWork {
  ProjectWork({
      this.projectName, 
      this.designation, 
      this.id,
      this.year,});

  ProjectWork.fromJson(dynamic json) {
    projectName = json['project_name'];
    designation = json['designation'];
    year = json['year'];
    id=json['id'];
  }
  String? projectName;
  String? designation;
  String? year;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['project_name'] = projectName;
    map['designation'] = designation;
    map['year'] = year;
    map['id']=id;
    return map;
  }

}

class MemberBasicDetails {
  MemberBasicDetails({
      this.name, 
      this.designation, 
      this.membershipNo, 
      this.joiningDate, 
      this.skills, 
      this.medium, 
      this.portifolioLink, 
      this.notes, 
      this.mobileNumber, 
      this.experience, 
      this.facebookLink, 
      this.instagramLink, 
      this.youtubeLink, 
      this.twitterLink, 
      this.subscription_end_date,
      this.linkedinLink, 
      this.image,});

  MemberBasicDetails.fromJson(dynamic json) {
    name = json['name'];
    designation = json['designation'];
    membershipNo = json['membership_no'];
    joiningDate = json['joining_date'];
    skills = json['skills'];
    medium = json['medium'];
    portifolioLink = json['portifolio_link'];
    notes = json['notes'];
    mobileNumber = json['mobile_number'];
    experience = json['experience'];
    facebookLink = json['facebook_link'];
    instagramLink = json['instagram_link'];
    youtubeLink = json['youtube_link'];
    twitterLink = json['twitter_link'];
    linkedinLink = json['linkedin_link'];
    image = json['image'];
    subscription_end_date=json['subscription_end_date'];
  }
  String? name;
  String? designation;
  String? membershipNo;
  String? joiningDate;
  String? skills;
  String? medium;
  String? portifolioLink;
  String? subscription_end_date;
  String? notes;
  String? mobileNumber;
  String? experience;
  String? facebookLink;
  String? instagramLink;
  String? youtubeLink;
  String? twitterLink;
  String? linkedinLink;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['designation'] = designation;
    map['membership_no'] = membershipNo;
    map['joining_date'] = joiningDate;
    map['skills'] = skills;
    map['medium'] = medium;
    map['portifolio_link'] = portifolioLink;
    map['notes'] = notes;
    map['subscription_end_date']=subscription_end_date;
    map['mobile_number'] = mobileNumber;
    map['experience'] = experience;
    map['facebook_link'] = facebookLink;
    map['instagram_link'] = instagramLink;
    map['youtube_link'] = youtubeLink;
    map['twitter_link'] = twitterLink;
    map['linkedin_link'] = linkedinLink;
    map['image'] = image;
    return map;
  }

}