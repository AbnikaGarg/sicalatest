class TopicModel {
  TopicModel({
      this.discussionForumDetails,});

  TopicModel.fromJson(dynamic json) {
    if (json['discussion_forum_details'] != null) {
      discussionForumDetails = [];
      json['discussion_forum_details'].forEach((v) {
        discussionForumDetails?.add(DiscussionForumDetails.fromJson(v));
      });
    }
  }
  List<DiscussionForumDetails>? discussionForumDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (discussionForumDetails != null) {
      map['discussion_forum_details'] = discussionForumDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class DiscussionForumDetails {
  DiscussionForumDetails({
      this.discussionDetails, 
      this.discussionComments,});

  DiscussionForumDetails.fromJson(dynamic json) {
    discussionDetails = json['discussion_details'] != null ? DiscussionDetails.fromJson(json['discussion_details']) : null;
    if (json['discussion_comments'] != null) {
      discussionComments = [];
      json['discussion_comments'].forEach((v) {
        discussionComments?.add(DiscussionComments.fromJson(v));
      });
    }
  }
  DiscussionDetails? discussionDetails;
  List<DiscussionComments>? discussionComments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (discussionDetails != null) {
      map['discussion_details'] = discussionDetails?.toJson();
    }
    if (discussionComments != null) {
      map['discussion_comments'] = discussionComments?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class DiscussionComments {
  DiscussionComments({
      this.profileImage, 
      this.comment, 
      this.commentCreateDate, 
      this.memberName, 
      this.designation, 
      this.commentId,});

  DiscussionComments.fromJson(dynamic json) {
    profileImage = json['profile_image'];
    comment = json['comment'];
    commentCreateDate = json['comment_create_date'];
    memberName = json['member_name'];
    designation = json['designation'];
    commentId = json['comment_id'];
  }
  String? profileImage;
  String? comment;
  String? commentCreateDate;
  String? memberName;
  String? designation;
  int? commentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profile_image'] = profileImage;
    map['comment'] = comment;
    map['comment_create_date'] = commentCreateDate;
    map['member_name'] = memberName;
    map['designation'] = designation;
    map['comment_id'] = commentId;
    return map;
  }

}

class DiscussionDetails {
  DiscussionDetails({
      this.profile, 
      this.topic, 
      this.memberName, 
      this.categoryName, 
      this.categoryId, 
      this.discussionId, 
      this.createDate, 
      this.memberId, 
      this.designation,});

  DiscussionDetails.fromJson(dynamic json) {
    profile = json['profile'];
    topic = json['topic'];
    memberName = json['member_name'];
    categoryName = json['category_name'];
    categoryId = json['category_id'];
    discussionId = json['discussion_id'];
    createDate = json['create_date'];
    memberId = json['member_id'];
    designation = json['designation'];
  }
  String? profile;
  String? topic;
  String? memberName;
  String? categoryName;
  int? categoryId;
  int? discussionId;
  String? createDate;
  int? memberId;
  String? designation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profile'] = profile;
    map['topic'] = topic;
    map['member_name'] = memberName;
    map['category_name'] = categoryName;
    map['category_id'] = categoryId;
    map['discussion_id'] = discussionId;
    map['create_date'] = createDate;
    map['member_id'] = memberId;
    map['designation'] = designation;
    return map;
  }

}