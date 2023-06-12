class ChickenModel {
  String? title;
  String? image;
  String? price;
  String? description;
  String? tybe;
  String? id;

  ChickenModel({this.title, this.image, this.price});
  ChickenModel.fromJosn(Map<String, dynamic> json) {
    image = json["image"];
    price = json["price"];
    title = json["title"];
    description = json["description"];
    tybe = json["tybe"];
    id = json["id"];
  }
}
