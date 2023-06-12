class OrderAdminModel {
  String? title;
  String? image;
  String? priceOrder;
  String? email;
  String? location;
  String? name;
  String? phone;
  String? description;
  String? id;
  OrderAdminModel({
    this.title,
    this.image,
    this.priceOrder,
    this.email,
    this.location,
    this.name,
    this.description,
    this.id,
  });
  OrderAdminModel.fromJosn(Map<String, dynamic> json) {
    image = json["image"];
    priceOrder = json["priceOrder"];
    title = json["title"];
    email = json["email"];
    location = json["location"];
    name = json["name"];
    phone = json["phone"];
    description = json["description"];
    description = json["id"];
  }
}
