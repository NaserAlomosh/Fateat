import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatmore_app/users/view_model/history/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/history/history.dart';

class HistoryCubit extends Cubit<HistoryStates> {
  HistoryCubit() : super(HistoryInitState());

  List<HistoryModel> dataAll = [];

  getHistory() async {
    emit(HistoryLoadingState());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('uid');
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("orders")
        .get()
        .then((value) {
      for (var element in value.docs) {
        dataAll.add(HistoryModel.fromJosn(element.data()));
      }
      emit(HistorySuccessState());
    });
  }
}
