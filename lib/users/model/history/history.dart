class HistoryModel {
  String? title;
  String? image;
  String? price;
  HistoryModel({this.title, this.image, this.price});
  HistoryModel.fromJosn(Map<String, dynamic> json) {
    image = json["image"];
    price = json["priceOrder"];
    title = json["title"];
  }
}
