class SearchModel {
  String? title;
  String? image;
  String? price;
  String? decoration;
  String? uid;
  SearchModel({this.title, this.image, this.price, String? decoration});
  SearchModel.fromJosn(Map<String, dynamic> json) {
    image = json["image"];
    price = json["price"];
    title = json["title"];
    decoration = json["description"];
    uid = json["uid"];
  }
}
