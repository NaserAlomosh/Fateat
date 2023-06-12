class PizzaModel {
  String? title;
  String? image;
  String? price;
  String? description;
  String? type;
  String? id;
  PizzaModel({this.title, this.image, this.price});
  PizzaModel.fromJosn(Map<String, dynamic> json) {
    image = json["image"];
    price = json["price"];
    title = json["title"];
    type = json["type"];
    id = json["id"];
    description = json["description"];
  }
}
