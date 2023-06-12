import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatmore_app/users/view_model/ruta_us/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RutaUsCubit extends Cubit<RutaUstState> {
  String? uid;
  String? image = "";
  String? name;
  String? firstCharName;
  RutaUsCubit() : super(RutaUstInitial());

  getUserData() async {
    emit(RutaUstLoading());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    image = prefs.getString('image').toString();
    name = prefs.getString('name').toString();
    firstChar();
    emit(RutaUsSuccess());
  }

  sendRutaUs({
    double? ruta,
  }) async {
    emit(RutaUstLoading());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid').toString();

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('rute')
        .doc()
        .set({
      "ruta": ruta,
    }).then((value) {
      emit(RutaUsSuccess());
      log("RUTA : $ruta");
    }).catchError((onError) {
      log('SEND DATA ERROR');
    });
  }

  void firstChar() {
    emit(RutaUstLoading());
    firstCharName = name![0];
    capitalChar();
    emit(RutaUsSuccess());
  }

//  (Methode) Get Capital Char from (name)
  void capitalChar() {
    firstCharName = firstCharName!.toUpperCase();
  }
}
