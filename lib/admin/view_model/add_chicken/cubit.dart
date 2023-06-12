import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatmore_app/admin/view_model/add_chicken/states.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddChickenCubit extends Cubit<AddChickenStates> {
  String? title;
  String? image;
  XFile? file;
  bool selectImage = false;
  File? imagePath;
  bool selected = false;
  String tybe = 'chicken';
  // ignore: prefer_typing_uninitialized_variables
  var url;
  String? id;
  AddChickenCubit() : super(AddChickenInitState());
  addAddChickenData() {}
  Future<void> getImagePicker() async {
    ImagePicker picker = ImagePicker();
    file = await picker.pickImage(source: ImageSource.gallery);
    //start upload
    if (file != null) {
      emit(AddChickenLoadingState());

      imagePath = File(file!.path);
      selectImage = true;
      var refStoreg = FirebaseStorage.instance.ref("images/$imagePath");

      await refStoreg.putFile(imagePath!);
      url = await refStoreg.getDownloadURL();

      log('IMAGE PATH :$url');
      emit(AddChickenSuccessState());

      //Success
    }
  }

  sendImageFirestore({String? decoration, String? price, String? title}) async {
    emit(AddChickenLoadingState());
    if (selectImage == true) {
      await FirebaseFirestore.instance
          .collection(tybe)
          .add({}).then((DocumentReference doc) async {
        id = doc.id;
        await FirebaseFirestore.instance.collection(tybe).doc(doc.id).set({
          "id": doc.id,
          "description": decoration,
          "image": url,
          "price": price,
          "title": title,
          "tybe": tybe,
        });
      });
      emit(AddChickenSendDataSuccessState());
    }

    log("get all data ");
  }
}
