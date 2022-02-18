import 'dart:convert';

import 'package:dio/dio.dart';

///
/// To help logging network communication that use [FormData] as body request
/// convert [FormData] request to JSON format
///
extension FormDataExtension on FormData {
  String toJson() {
    final fields = this.fields;
    final files = this.files;
    final map = <String?, String?>{};

    if (fields.isNotEmpty) {
      for (MapEntry<String?, String?> field in fields) {
        map[field.key] = field.value;
      }
    }

    if (files.isNotEmpty) {
      for (MapEntry<String?, MultipartFile> file in files) {
        map[file.key] = file.value.filename;
      }
    }

    return json.encode(map);
  }
}
