import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String date;
  String username;
  String profile;
  String emailId;
  String status;

  UserModel({
    required this.id,
    required this.date,
    required this.username,
    required this.profile,
    required this.emailId,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        date: json["date"],
        username: json["username"],
        profile: json["profile"],
        emailId: json["email_id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "username": username,
        "profile": profile,
        "email_id": emailId,
        "status": status,
      };
}
