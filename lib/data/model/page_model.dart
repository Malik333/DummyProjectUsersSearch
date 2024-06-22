
class PageModel<T> {
  List<T>? data;
  int? total;
  int? skip;
  int? limit;
  late bool? isLastPage;

  PageModel({this.data, this.total, this.skip, this.limit}) {
    isLastPage = (skip! + limit!) >= total!;
  }

  factory  PageModel.fromJson(Map<String,dynamic> json,Function fromJsonModel){
    final items = json['products'].cast<Map<String, dynamic>>();
    return PageModel<T>(
        total: json['total'],
        skip: json['skip'],
        limit: json['limit'],
        data: List<T>.from(items.map((itemsJson) => fromJsonModel(itemsJson)))
    );
  }
}