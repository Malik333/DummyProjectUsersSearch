class PayloadLogModel {
  String? description;

  PayloadLogModel(
      {this.description});

  PayloadLogModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['description'] = description;
    return data;
  }
}
