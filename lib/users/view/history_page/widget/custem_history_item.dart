import 'package:flutter/material.dart';

class CustemIthemHistory extends StatelessWidget {
  final String image;

  final String price;

  final String title;

  const CustemIthemHistory(
      {Key? key, required this.image, required this.price, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image(image: NetworkImage(image)),
        trailing: Text(price),
        title: Text(title),
      ),
    );
  }
}
