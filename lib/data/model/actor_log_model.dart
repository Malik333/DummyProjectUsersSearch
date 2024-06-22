class ActorLogModel {
  String? login;

  ActorLogModel(
      {this.login});

  ActorLogModel.fromJson(Map<String, dynamic> json) {
    login = json['login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['login'] = login;
    return data;
  }
}
