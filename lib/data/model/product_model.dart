class ProductModel {
  int? id;
  String? title;
  String? description;
  int? price;
  String? thumbnail;

  ProductModel(
      {this.id,
        this.title,
        this.description,
        this.price,
        this.thumbnail});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['thumbnail'] = thumbnail;
    return data;
  }
}