import 'package:giri/services/models/base_model.dart';

class LoginModel extends BaseModel {
  String accessToken;

  LoginModel({required this.accessToken, required bool success}) : super(success: success);

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json['accessToken'],
      success: json['success'] ?? false,
    );
  }
}
