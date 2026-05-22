class UserModel {
  final String name;
  final String email;
  final String phone;
  final String userId;
  final String image;
  final String password;


  UserModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.userId,
    required this.password,
    this.image = 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      userId: json['userId'],
      image: json['image'],
      password: json['password'],
    );
  }

  toJson() {
    return {
      'email' : email,
      'name' : name,
      'phone' : phone,
      'userId' : userId,
      'image' : image,
      'password' : password,
    };
  }
}
