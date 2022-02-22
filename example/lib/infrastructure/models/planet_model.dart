class PlanetModel {
  final int id;
  final String name;
  final String description;
  final String image;

  PlanetModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  factory PlanetModel.fromJson(Map<String, dynamic> json) => PlanetModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['description'] = description;
    json['image'] = image;
    return json;
  }
}
