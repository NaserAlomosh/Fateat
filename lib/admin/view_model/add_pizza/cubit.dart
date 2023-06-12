import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatmore_app/admin/view_model/add_pizza/states.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddPizzaCubit extends Cubit<AddPizzaStates> {
  String? title;
  String? image;
  XFile? file;
  bool selectImage = false;
  File? imagePath;
  bool selected = false;
  String tybe = 'pizza';
  // ignore: prefer_typing_uninitialized_variables
  var url;
  String? id;
  AddPizzaCubit() : super(AddPizzaInitState());
  addAddPizzaData() {}
  Future<void> getImagePicker() async {
    ImagePicker picker = ImagePicker();
    file = await picker.pickImage(source: ImageSource.gallery);
    //start upload
    if (file != null) {
      emit(AddPizzaLoadingState());

      imagePath = File(file!.path);
      selectImage = true;
      var refStoreg = FirebaseStorage.instance.ref("images/$imagePath");

      await refStoreg.putFile(imagePath!);
      url = await refStoreg.getDownloadURL();

      log('IMAGE PATH :$url');
      emit(AddPizzaSuccessState());

      //Success
    }
  }

  sendImageFirestore({String? decoration, String? price, String? title}) async {
    emit(AddPizzaLoadingState());
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
      emit(AddPizzaSendDataSuccessState());
    }

    log("get all data ");
  }
}
