import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatmore_app/users/view_model/pizza/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/pizza/pizza_model.dart';

class PizzaCubit extends Cubit<PizzaStates> {
  List<PizzaModel> pizzaList = [];

  PizzaCubit() : super(PizzaInitState());
  getPizzaData() {
    emit(PizzaLoadingState());
    FirebaseFirestore.instance.collection("pizza").get().then((value) {
      for (var element in value.docs) {
        pizzaList.add(PizzaModel.fromJosn(element.data()));
      }
      emit(PizzaSuccessState());
    }).catchError((onError) {
      emit(PizzaErrorState());
      log('Pizza DONT GET DATA');
    });
  }
}
