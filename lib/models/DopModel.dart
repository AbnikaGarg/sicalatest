class DopModel {
  DopModel({
      this.shootingDopAllDetails,});

  DopModel.fromJson(dynamic json) {
    if (json['shooting_dop_all_details'] != null) {
      shootingDopAllDetails = [];
      json['shooting_dop_all_details'].forEach((v) {
        shootingDopAllDetails?.add(ShootingDopAllDetails.fromJson(v));
      });
    }
  }
  List<ShootingDopAllDetails>? shootingDopAllDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (shootingDopAllDetails != null) {
      map['shooting_dop_all_details'] = shootingDopAllDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ShootingDopAllDetails {
  ShootingDopAllDetails({
      this.shootingDopDetails, 
      this.associate,});

  ShootingDopAllDetails.fromJson(dynamic json) {
    shootingDopDetails = json['shooting_dop_details'] != null ? ShootingDopDetails.fromJson(json['shooting_dop_details']) : null;
    if (json['associate'] != null) {
      associate = [];
      json['associate'].forEach((v) {
        associate?.add(Associate.fromJson(v));
      });
    }
  }
  ShootingDopDetails? shootingDopDetails;
  List<Associate>? associate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (shootingDopDetails != null) {
      map['shooting_dop_details'] = shootingDopDetails?.toJson();
    }
    if (associate != null) {
      map['associate'] = associate?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Associate {
  Associate({
      this.name, 
      this.mobileNumber, 
      this.shootingId, 
      this.memberNumber, 
      this.memberId,});

  Associate.fromJson(dynamic json) {
    name = json['name'];
    mobileNumber = json['mobile_number'];
    shootingId = json['shooting_id'];
    memberNumber = json['member_number'];
    memberId = json['member_id'];
  }
  String? name;
  String? mobileNumber;
  int? shootingId;
  String? memberNumber;
  int? memberId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['mobile_number'] = mobileNumber;
    map['shooting_id'] = shootingId;
    map['member_number'] = memberNumber;
    map['member_id'] = memberId;
    return map;
  }

}

class ShootingDopDetails {
  ShootingDopDetails({
      this.mobileNumber, 
      this.memberId, 
      this.shootingId, 
      this.memberName, 
      this.memberNumber, 
      this.designation, 
      this.projectTitle, 
      this.mediumId, 
      this.mediumName, 
      this.startDate, 
      this.endDate, 
      this.outdoorLinkDetails,});

  ShootingDopDetails.fromJson(dynamic json) {
    mobileNumber = json['mobile_number'];
    memberId = json['member_id'];
    shootingId = json['shooting_id'];
    memberName = json['member_name'];
    memberNumber = json['member_number'];
    designation = json['designation'];
    projectTitle = json['project_title'];
    mediumId = json['medium_id'].toString();
    mediumName = json['medium_name'].toString();
    startDate = json['start_date'];
    endDate = json['end_date'];
    outdoorLinkDetails = json['outdoor_link_details'];
  }
  String? mobileNumber;
  int? memberId;
  int? shootingId;
  String? memberName;
  String? memberNumber;
  String? designation;
  String? projectTitle;
  String? mediumId;
  String? mediumName;
  String? startDate;
  String? endDate;
  String? outdoorLinkDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile_number'] = mobileNumber;
    map['member_id'] = memberId;
    map['shooting_id'] = shootingId;
    map['member_name'] = memberName;
    map['member_number'] = memberNumber;
    map['designation'] = designation;
    map['project_title'] = projectTitle;
    map['medium_id'] = mediumId!.toString();
    map['medium_name'] = mediumName.toString();
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['outdoor_link_details'] = outdoorLinkDetails;
    return map;
  }

}