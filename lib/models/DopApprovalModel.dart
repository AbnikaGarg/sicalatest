class DopApprovalModel {
  DopApprovalModel({
      this.dopAssociateAllDetails,});

  DopApprovalModel.fromJson(dynamic json) {
    if (json['dop_associate_all_details'] != null) {
      dopAssociateAllDetails = [];
      json['dop_associate_all_details'].forEach((v) {
        dopAssociateAllDetails?.add(DopAssociateAllDetails.fromJson(v));
      });
    }
  }
  List<DopAssociateAllDetails>? dopAssociateAllDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dopAssociateAllDetails != null) {
      map['dop_associate_all_details'] = dopAssociateAllDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class DopAssociateAllDetails {
  DopAssociateAllDetails({
      this.shootingDopDetails, 
      this.associate, 
      this.shootingDetails,});

  DopAssociateAllDetails.fromJson(dynamic json) {
    shootingDopDetails = json['shooting_dop_details'] != null ? ShootingDopDetails.fromJson(json['shooting_dop_details']) : null;
    if (json['associate'] != null) {
      associate = [];
      json['associate'].forEach((v) {
        associate?.add(Associate.fromJson(v));
      });
    }
    if (json['shooting_details'] != null) {
      shootingDetails = [];
      json['shooting_details'].forEach((v) {
        shootingDetails?.add(ShootingDetails.fromJson(v));
      });
    }
  }
  ShootingDopDetails? shootingDopDetails;
  List<Associate>? associate;
  List<ShootingDetails>? shootingDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (shootingDopDetails != null) {
      map['shooting_dop_details'] = shootingDopDetails?.toJson();
    }
    if (associate != null) {
      map['associate'] = associate?.map((v) => v.toJson()).toList();
    }
    if (shootingDetails != null) {
      map['shooting_details'] = shootingDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ShootingDetails {
  ShootingDetails({
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
      this.notes, 
      this.id,});

  ShootingDetails.fromJson(dynamic json) {
    mobileNumber = json['mobile_number'];
    memberId = json['member_id'];
    shootingId = json['shooting_id'];
    memberName = json['member_name'];
    memberNumber = json['member_number'];
    designation = json['designation'];
    projectTitle = json['project_title'];
    mediumId = json['medium_id'];
    mediumName = json['medium_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    notes = json['notes'];
    id = json['id'];
  }
  String? mobileNumber;
  int? memberId;
  int? shootingId;
  String? memberName;
  String? memberNumber;
  String? designation;
  String? projectTitle;
  int? mediumId;
  String? mediumName;
  String? startDate;
  String? endDate;
  String? notes;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile_number'] = mobileNumber;
    map['member_id'] = memberId;
    map['shooting_id'] = shootingId;
    map['member_name'] = memberName;
    map['member_number'] = memberNumber;
    map['designation'] = designation;
    map['project_title'] = projectTitle;
    map['medium_id'] = mediumId;
    map['medium_name'] = mediumName;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['notes'] = notes;
    map['id'] = id;
    return map;
  }

}

class Associate {
  Associate({
      this.associateId, 
      this.mobileNumber, 
      this.shootingId, 
      this.memberNumber, 
      this.memberId, 
      this.shootingNote, 
      this.memberName, 
      this.designation, 
      this.projectTitle, 
      this.mediumId, 
      this.mediumName, 
      this.startDate, 
      this.endDate, 
      this.outdoorLinkDetails, 
      this.attending,});

  Associate.fromJson(dynamic json) {
    associateId = json['associate_id'];
    mobileNumber = json['mobile_number'];
    shootingId = json['shooting_id'];
    memberNumber = json['member_number'];
    memberId = json['member_id'];
    shootingNote = json['shooting_note'];
    memberName = json['member_name'];
    designation = json['designation'];
    projectTitle = json['project_title'];
    mediumId = json['medium_id'];
    mediumName = json['medium_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    outdoorLinkDetails = json['outdoor_link_details'];
    attending = json['attending'];
  }
  int? associateId;
  String? mobileNumber;
  int? shootingId;
  String? memberNumber;
  int? memberId;
  String? shootingNote;
  String? memberName;
  String? designation;
  String? projectTitle;
  int? mediumId;
  String? mediumName;
  String? startDate;
  String? endDate;
  String? outdoorLinkDetails;
  bool? attending;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['associate_id'] = associateId;
    map['mobile_number'] = mobileNumber;
    map['shooting_id'] = shootingId;
    map['member_number'] = memberNumber;
    map['member_id'] = memberId;
    map['shooting_note'] = shootingNote;
    map['member_name'] = memberName;
    map['designation'] = designation;
    map['project_title'] = projectTitle;
    map['medium_id'] = mediumId;
    map['medium_name'] = mediumName;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['outdoor_link_details'] = outdoorLinkDetails;
    map['attending'] = attending;
    return map;
  }

}

class ShootingDopDetails {
  ShootingDopDetails({
      this.mobileNumber, 
      this.memberId, 
      this.shootingId, 
      this.shootingDopId, 
      this.shootingNote, 
      this.memberName, 
      this.memberNumber, 
      this.designation, 
      this.projectTitle, 
      this.mediumId, 
      this.mediumName, 
      this.startDate, 
      this.endDate, 
      this.outdoorLinkDetails, 
      this.attending,});

  ShootingDopDetails.fromJson(dynamic json) {
    mobileNumber = json['mobile_number'];
    memberId = json['member_id'];
    shootingId = json['shooting_id'];
    shootingDopId = json['shooting_dop_id'];
    shootingNote = json['shooting_note'];
    memberName = json['member_name'];
    memberNumber = json['member_number'];
    designation = json['designation'];
    projectTitle = json['project_title'];
    mediumId = json['medium_id'];
    mediumName = json['medium_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    outdoorLinkDetails = json['outdoor_link_details'];
    attending = json['attending'];
  }
  String? mobileNumber;
  int? memberId;
  int? shootingId;
  int? shootingDopId;
  String? shootingNote;
  String? memberName;
  String? memberNumber;
  String? designation;
  String? projectTitle;
  int? mediumId;
  String? mediumName;
  String? startDate;
  String? endDate;
  String? outdoorLinkDetails;
  bool? attending;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile_number'] = mobileNumber;
    map['member_id'] = memberId;
    map['shooting_id'] = shootingId;
    map['shooting_dop_id'] = shootingDopId;
    map['shooting_note'] = shootingNote;
    map['member_name'] = memberName;
    map['member_number'] = memberNumber;
    map['designation'] = designation;
    map['project_title'] = projectTitle;
    map['medium_id'] = mediumId;
    map['medium_name'] = mediumName;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['outdoor_link_details'] = outdoorLinkDetails;
    map['attending'] = attending;
    return map;
  }

}