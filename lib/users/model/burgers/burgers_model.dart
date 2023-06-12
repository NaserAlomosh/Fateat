class BurgersModel {
  String? title;
  String? image;
  String? price;
  String? tybe;
  String? description;
  String? id;

  BurgersModel({this.title, this.image, this.price, this.tybe});
  BurgersModel.fromJosn(Map<String, dynamic> json) {
    image = json["image"];
    price = json["price"];
    title = json["title"];
    description = json["description"];
    tybe = json["tybe"];
    id = json["id"];
  }
}
