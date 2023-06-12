import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatmore_app/users/view_model/burgers/states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/burgers/burgers_model.dart';

class BurgersCubit extends Cubit<BurgersStates> {
  List<BurgersModel> burgerList = [];

  BurgersCubit() : super(BurgersInitState());
  getBurgerData() {
    emit(BurgersLoadingState());
    FirebaseFirestore.instance.collection("burgers").get().then((value) {
      for (var element in value.docs) {
        burgerList.add(BurgersModel.fromJosn(element.data()));
      }
      emit(BurgersSuccessState());
    }).catchError((onError) {
      emit(BurgersErrorState());
      log('Burgers DONT GET DATA');
    });
  }
}
