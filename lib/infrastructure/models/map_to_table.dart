import 'package:network_inspector/infrastructure/models/definition_model.dart';

class MapToTable {
  final String tableName;
  final List<DefinitionModel>? definition;
  MapToTable({
    required this.tableName,
    this.definition,
  });

  factory MapToTable.fromJson(Map<String, dynamic> json) => MapToTable(
        tableName: json['tabel_name'],
        definition: (json['definition']) != null
            ? List<DefinitionModel>.from(
                (json['definition']).map(
                  (definition) => DefinitionModel.fromJson(definition),
                ),
              )
            : null,
      );
}
