import 'dart:convert';

List<HomeSliderModel> homeSliderModelFromJson(String str) => List<HomeSliderModel>.from(json.decode(str).map((x) => HomeSliderModel.fromJson(x)));

String homeSliderModelToJson(List<HomeSliderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeSliderModel {
    String id;
    String image;
    String url;

    HomeSliderModel({
        required this.id,
        required this.image,
        required this.url,
    });

    factory HomeSliderModel.fromJson(Map<String, dynamic> json) => HomeSliderModel(
        id: json["id"],
        image: json["image"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "url": url,
    };
}
