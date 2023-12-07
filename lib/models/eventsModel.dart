import 'dart:convert';

List<EventsModel> eventsModelFromJson(String str) => List<EventsModel>.from(
    json.decode(str).map((x) => EventsModel.fromJson(x)));

String eventsModelToJson(List<EventsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventsModel {
  String id;
  String clubId;
  String clubName;
  String url;
  String username;
  String postedEmail;
  String image;
  String title;
  String description;
  DateTime date;
  String time;
  DateTime deadline;
  String venue;
  String eventTime;
  DateTime eventDate;

  EventsModel({
    required this.id,
    required this.clubId,
    required this.clubName,
    required this.url,
    required this.username,
    required this.postedEmail,
    required this.image,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.deadline,
    required this.venue,
    required this.eventTime,
    required this.eventDate,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) => EventsModel(
        id: json["id"],
        clubId: json["club_id"],
        clubName: json["club_name"],
        url: json["url"],
        username: json["username"],
        postedEmail: json["posted_email"],
        image: json["image"],
        title: json["title"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        deadline: DateTime.parse(json["deadline"]),
        venue: json["venue"],
        eventTime: json["event_time"],
        eventDate: DateTime.parse(json["event_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "club_id": clubId,
        "club_name": clubName,
        "url": url,
        "username": username,
        "posted_email": postedEmail,
        "image": image,
        "title": title,
        "description": description,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "deadline":
            "${deadline.year.toString().padLeft(4, '0')}-${deadline.month.toString().padLeft(2, '0')}-${deadline.day.toString().padLeft(2, '0')}",
        "venue": venue,
        "event_time": eventTime,
        "event_date":
            "${eventDate.year.toString().padLeft(4, '0')}-${eventDate.month.toString().padLeft(2, '0')}-${eventDate.day.toString().padLeft(2, '0')}",
      };
}
