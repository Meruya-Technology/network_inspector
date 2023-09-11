/// @nodoc
class DefinitionModel {
  final String? fields;
  final String? type;
  final String? attribute;

  DefinitionModel({
    this.fields,
    this.type,
    this.attribute,
  });

  factory DefinitionModel.fromJson(Map<String, dynamic> json) =>
      DefinitionModel(
        fields: json['fields'],
        type: json['type'],
        attribute: json['attribute'],
      );
}
