import 'dart:convert';

List<ClubsModel> clubsModelFromJson(String str) =>
    List<ClubsModel>.from(json.decode(str).map((x) => ClubsModel.fromJson(x)));

String clubsModelToJson(List<ClubsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClubsModel {
  String id;
  String image;
  String name;
  String president;
  String members;
  String type;
  String instagram;
  String twitter;
  String linkedin;
  String whatsapp;
  String description;
  String facultyCoordinator;
  String totalEvents;

  ClubsModel({
    required this.id,
    required this.image,
    required this.name,
    required this.president,
    required this.members,
    required this.type,
    required this.instagram,
    required this.twitter,
    required this.linkedin,
    required this.whatsapp,
    required this.description,
    required this.facultyCoordinator,
    required this.totalEvents,
  });

  factory ClubsModel.fromJson(Map<String, dynamic> json) => ClubsModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        president: json["president"],
        members: json["members"],
        type: json["type"],
        instagram: json["instagram"],
        twitter: json["twitter"],
        linkedin: json["linkedin"],
        whatsapp: json["whatsapp"],
        description: json["description"],
        facultyCoordinator: json["faculty_coordinator"],
        totalEvents: json["total_events"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "president": president,
        "members": members,
        "type": type,
        "instagram": instagram,
        "twitter": twitter,
        "linkedin": linkedin,
        "whatsapp": whatsapp,
        "description": description,
        "faculty_coordinator": facultyCoordinator,
        "total_events": totalEvents,
      };
}
