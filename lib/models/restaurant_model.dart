import 'package:mini_project_flutter_alterra/utils/config.dart';

class RestaurantModel {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  String? review;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.review,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "review": review,
      };

  String getSmallPicture() => Config.imageSmall + pictureId;
  String getMediumPicture() => Config.imageMedium + pictureId;
  String getLargePicture() => Config.imageLarge + pictureId;
}
