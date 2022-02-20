class CreatePlanetRequestModel {
  final String name;
  final String description;

  CreatePlanetRequestModel({
    required this.name,
    required this.description,
  });

  factory CreatePlanetRequestModel.fromJson(Map<String, dynamic> json) =>
      CreatePlanetRequestModel(
        name: json['name'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['description'] = description;
    return json;
  }
}
