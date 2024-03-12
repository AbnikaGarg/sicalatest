class GalleryModel {
  GalleryModel({
      this.galleryDetails,});

  GalleryModel.fromJson(dynamic json) {
    if (json['gallery_details'] != null) {
      galleryDetails = [];
      json['gallery_details'].forEach((v) {
        galleryDetails?.add(GalleryDetails.fromJson(v));
      });
    }
  }
  List<GalleryDetails>? galleryDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (galleryDetails != null) {
      map['gallery_details'] = galleryDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class GalleryDetails {
  GalleryDetails({
      this.name, 
      this.description, 
      this.image, 
      this.date, 
      this.likeCount, 
      this.comment, 
      this.galleryId,});

  GalleryDetails.fromJson(dynamic json) {
    name = json['name'];
    description = json['description'];
    image = json['image'];
    date = json['date'];
    likeCount = json['like_count'];
    comment = json['comment'];
    galleryId = json['gallery_id'];
  }
  String? name;
  String? description;
  String? image;
  String? date;
  int? likeCount;
  int? comment;
  int? galleryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['description'] = description;
    map['image'] = image;
    map['date'] = date;
    map['like_count'] = likeCount;
    map['comment'] = comment;
    map['gallery_id'] = galleryId;
    return map;
  }

}