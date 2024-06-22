class UserModel {
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? image;
  int? age;
  String? token;
  String? university;

  UserModel(
      {this.id,
      this.username,
      this.email,
      this.firstName,
      this.lastName,
      this.gender,
      this.image,
      this.age,
      this.university,
      this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    image = json['image'];
    age = json['age'];
    token = json['token'];
    university = json['university'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    data['image'] = image;
    data['age'] = age;
    data['token'] = token;
    data['university'] = university;
    return data;
  }
}
