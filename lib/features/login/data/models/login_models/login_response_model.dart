 
import 'package:movie_app/features/login/domain/entites/user_data_entity.dart';

class LoginResponseModel extends UserDataEntity {
  const LoginResponseModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data']['user'] as Map<String, dynamic>;
    return LoginResponseModel(
      id: data['id'] as int,
      fullName: data['full_name'] as String,
      email: data['email'] as String,
      token: json['data']['token'] as String,
    );
  }
}
