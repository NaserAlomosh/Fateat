import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatmore_app/users/view_model/sign_in/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninCubit extends Cubit<SigninStates> {
  String? uid;
  String? firstCharName;
  String? name;

  SharedPreferences? prefs;
  SigninCubit() : super(SigninInitState());
  Future<void> signInUser({String? email, String? password}) async {
    emit(SigninLoadingState());
    try {
      if (isEmailValid(email!)) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: email,
          password: password!,
        )
            .then((value) async {
          prefs = await SharedPreferences.getInstance();
          uid = FirebaseAuth.instance.currentUser!.uid.toString();
          prefs!.setString('uid', uid!);
          saveDataToSharedPreferences();
        });
      } else {
        emit(SigninEmailOrPasswordErrorState());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(SigninNotFoundUserState());
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        emit(SigninEmailOrPasswordErrorState());
        log('Wrong password provided for that user.');
      }
    }
  }

  saveDataToSharedPreferences() async {
    saveSharedPreferencesEmail();
    saveSharedPreferencesName();
    saveSharedPreferencesPhone();
    saveSharedPreferencesImage();
  }

  Future<void> saveSharedPreferencesEmail() async {
    emit(SigninLoadingState());
    prefs = await SharedPreferences.getInstance();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      prefs!.setString('email', value.get('email'));
      log('SAVE EMAIL : ${value.get('email')}');
    });
  }

  Future<void> saveSharedPreferencesPhone() async {
    emit(SigninLoadingState());
    prefs = await SharedPreferences.getInstance();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      prefs!.setString('phone', value.get('phone')).then((value) {});
      log('SAVE PHONE : ${value.get('phone')}');
    });
  }

  Future<void> saveSharedPreferencesName() async {
    emit(SigninLoadingState());
    prefs = await SharedPreferences.getInstance();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      prefs!.setString('name', value.get('name'));
      firstChar(name: value.get('name'));
      log('SAVE NAME : ${value.get('name')}');
    });
  }

  Future<void> saveSharedPreferencesImage() async {
    emit(SigninLoadingState());
    prefs = await SharedPreferences.getInstance();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      prefs!.setString('image', value.get('image'));
      log('SAVE IMAGE : ${value.get('image')}');
      emit(SigninSuccessState());
    });
  }

  bool isEmailValid(String email) {
    return email.contains('@');
  }

//  (Methode) Get Capital Char from (name)

  //  (Methode) Get First Char from (name)
  void firstChar({String? name}) {
    firstCharName = name![0];

    capitalChar(name: firstCharName);
  }

  void capitalChar({String? name}) {
    firstCharName = firstCharName!.toUpperCase();
    prefs!.setString('FirstChar', firstCharName!).toString();
    log('Capital First Cart NAME   $firstCharName');
  }
}
