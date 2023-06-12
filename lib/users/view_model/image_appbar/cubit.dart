import 'dart:developer';

import 'package:eatmore_app/users/view_model/image_appbar/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageAppBarCubit extends Cubit<ImageAppBarStates> {
  ImageAppBarCubit() : super(ImageAppBarInitState());
  String? image;
  String? uid;
  SharedPreferences? prefe;
  String? firstCharName;

  getImageAppBarData() async {
    emit(ImageAppBarLoadingState());
    prefe = await SharedPreferences.getInstance();
    uid = prefe!.get('uid').toString();
    getImage();
    getFirstCartName();
  }

  getImage() async {
    emit(ImageAppBarLoadingState());
    prefe = await SharedPreferences.getInstance();
    await SharedPreferences.getInstance().then((value) {
      image = prefe!.get('image').toString();
      emit(ImageAppBarSuccessState());
    });

    log('AppBar IMAGE $image');
  }

  getFirstCartName() async {
    emit(ImageAppBarLoadingState());

    prefe = await SharedPreferences.getInstance();
    firstCharName = prefe!.get('FirstChar').toString();
    log('HOME FirstChar $firstCharName');
    emit(ImageAppBarSuccessState());
  }

//  (Methode) Get First Char from (name)

}
