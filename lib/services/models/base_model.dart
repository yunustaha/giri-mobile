class BaseModel {
  bool success;

  BaseModel({required this.success});

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return BaseModel(
      success: json['success'] ?? false,
    );
  }
}
