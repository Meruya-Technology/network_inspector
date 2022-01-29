import 'planet_model.dart';

class FetchPlanetResponseModel {
  final String message;
  final List<PlanetModel> data;

  FetchPlanetResponseModel({
    required this.message,
    required this.data,
  });

  factory FetchPlanetResponseModel.fromJson(Map<String, dynamic> json) =>
      FetchPlanetResponseModel(
        message: json['message'],
        data: List<PlanetModel>.from(
          json['data'].map(
            (json) => PlanetModel.fromJson(json),
          ),
        ),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['message'] = message;
    json['data'] = data.map((model) => model.toJson()).toList();
    return json;
  }
}
