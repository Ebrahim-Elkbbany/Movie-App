import 'package:movie_app/features/login/domain/entites/login_request_entity.dart';

class LoginRequestModel extends LoginRequestEntity {
  LoginRequestModel({required super.email, required super.password, super.deviceToken});


  Map<String, dynamic> toJson() => {'email': email, 'password': password, 'deviceToken': deviceToken};
}
