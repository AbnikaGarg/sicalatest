class EventModel {
  EventModel({
      this.eventDetails,});

  EventModel.fromJson(dynamic json) {
    if (json['event_details'] != null) {
      eventDetails = [];
      json['event_details'].forEach((v) {
        eventDetails?.add(EventDetails.fromJson(v));
      });
    }
  }
  List<EventDetails>? eventDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (eventDetails != null) {
      map['event_details'] = eventDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class EventDetails {
  EventDetails({
      this.title, 
      this.description, 
      this.startDate, 
      this.endDate, 
      this.coachName, 
      this.amount, 
      this.eventId, 
      this.image,});

  EventDetails.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    coachName = json['coach_name'];
    amount = json['amount'];
    eventId = json['event_id'];
    image = json['image_url'];
  }
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  String? coachName;
  double? amount;
  int? eventId;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['coach_name'] = coachName;
    map['amount'] = amount;
    map['event_id'] = eventId;
    map['image'] = image;
    return map;
  }

}