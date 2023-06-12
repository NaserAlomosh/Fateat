import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatmore_app/users/view_model/sign_up/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  DateTime selectDate = DateTime.now();

  SignUpCubit() : super(SignUpInitState());
  String image = "https://cdn-icons-png.flaticon.com/512/149/149071.png";
  String? uid;

  Future<void> signUpUser(
      {String? email, String? pass, String? name, String? phone}) async {
    try {
      emit(SignUpLoadingState());

      if (isEmailValid(email!)) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email,
          password: pass!,
        )
            .then((value) {
          saveData(
              email: email, uid: uid, name: name, image: image, phone: phone);
        });
      } else {
        emit(SignUpEmailInValidState());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpErrorPassworState());
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpEmailErrorState());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  saveData(
      {String? email,
      String? uid,
      String? name,
      String? image,
      String? phone}) async {
    emit(SignUpLoadingState());
    uid = FirebaseAuth.instance.currentUser!.uid.toString();
    FirebaseFirestore.instance.collection("users").doc(uid.toString()).set({
      "email": email,
      "name": name,
      "uid": uid,
      "image": image,
      "phone": phone
    });
    emit(SignUpSuccessState());
  }

  bool isEmailValid(String email) {
    return email.contains('@');
  }
}
