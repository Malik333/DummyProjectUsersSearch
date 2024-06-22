class CredentialsModel {
  final String email;
  final String password;

  CredentialsModel({
    required this.email,
    required this.password,
  });

  factory CredentialsModel.fromJson(Map<String, dynamic> json) {
    return CredentialsModel(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}