import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

part 'state.dart';

class ShopCartCubit extends Cubit<ShopCartState> {
  String? uid;
  String? location;
  String? id;
  String? email;
  String? phone;
  String? name;
  String? description;

  ShopCartCubit() : super(ShopCartInitial());

  sendOrderToHistoryData(String? image, String? price, String? title) async {
    emit(ShopCartLoading());
    uid = FirebaseAuth.instance.currentUser!.uid.toString();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('orders')
        .doc()
        .set({"image": image, "priceOrder": price, "title": title});
  }

  sendOrderToAdmin(String? image, String? price, String? title) async {
    emit(ShopCartLoading());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    name = prefs.getString('name');
    phone = prefs.getString('phone');
    uid = FirebaseFirestore.instance.collection('admin').doc().id;
    await FirebaseFirestore.instance.collection('admin').doc(uid).set({
      "phone": phone,
      "email": email,
      "name": name,
      "uid": uid,
      "location": location,
      "image": image,
      "priceOrder": price,
      "title": title,
      "description": description,
    });
    emit(ShopCartSuccess());
  }

  Future<void> getLocation() async {
    emit(ShopCartLoading());

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      log('location :  ${value.latitude} ++ ${value.longitude}');
      location = '${value.latitude} : ${value.longitude} ';
      log('location   $location');
    });
  }

  deleteOrderData({int? id}) {
    emit(ShopCartLoading());

    database.deleteDatabase(id: id).then((value) {
      emit(ShopCartSuccess());
    });
  }
}
