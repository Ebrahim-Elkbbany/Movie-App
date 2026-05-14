class LoginRequestEntity {
  final String email;
  final String password;
  final String? deviceToken;

  LoginRequestEntity({required this.email, required this.password, this.deviceToken});
}
