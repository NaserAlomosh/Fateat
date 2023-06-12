import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatmore_app/admin/model/order_admin.dart';
import 'package:eatmore_app/admin/view_model/order_admin/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderAdminCubit extends Cubit<OrderAdminStates> {
  List<OrderAdminModel> orderAdminList = [];

  OrderAdminCubit() : super(OrderAdminInitState());
  getOrderAdmin() async {
    emit(OrderAdminLoadingState());
    await FirebaseFirestore.instance.collection("admin").get().then((value) {
      for (var element in value.docs) {
        orderAdminList.add(OrderAdminModel.fromJosn(element.data()));
      }
      emit(OrderAdminSuccessState());
    }).catchError((onError) {
      emit(OrderAdminErrorState());
      log('OrderAdmin DONT GET DATA');
    });
  }

  deleteOrderAdmin({String? id}) async {
    try {
      emit(OrderAdminLoadingState());
      await FirebaseFirestore.instance
          .collection('admin')
          .doc(id)
          .delete()
          .then((value) {
        emit(OrderAdminSuccessState());
      });
    } catch (e) {
      return false;
    }
  }
}
