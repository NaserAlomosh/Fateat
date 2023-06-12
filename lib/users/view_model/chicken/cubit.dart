import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatmore_app/users/view_model/chicken/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/chicken/chicken_model.dart';

class ChickenCubit extends Cubit<ChickenStates> {
  List<ChickenModel> chickenList = [];

  ChickenCubit() : super(ChickenInitState());
  getChickenData() {
    emit(ChickenLoadingState());
    FirebaseFirestore.instance.collection("chicken").get().then((value) {
      for (var element in value.docs) {
        chickenList.add(ChickenModel.fromJosn(element.data()));
      }
      emit(ChickenSuccessState());
    }).catchError((onError) {
      emit(ChickenErrorState());
      log('Chicken DONT GET DATA');
    });
  }
}
