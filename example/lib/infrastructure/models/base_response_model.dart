class BaseResponseModel {
  final String message;

  BaseResponseModel({
    required this.message,
  });

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) =>
      BaseResponseModel(
        message: json['message'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['message'] = message;
    return json;
  }
}
