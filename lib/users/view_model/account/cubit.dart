import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatmore_app/users/view_model/account/state.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountCubit extends Cubit<AccountState> {
  SharedPreferences? prefs;
  String? uid;
  String? name;
  String? email;
  String? phoneNumber;
  String? image = "";
  XFile? file;
  String? saveUrlImage;
  bool selectImage = false;
  File? imagePath;
  String? firstCharName;
  bool selected = false;

  AccountCubit() : super(AccountInitialState());
//  (Methode) Get All data (Username , Phone Number, Email, Image)
  getData() async {
    emit(AccountLoadingState());
    prefs = await SharedPreferences.getInstance();
    uid = prefs!.getString('uid').toString();
    image = prefs!.get('image').toString();

    getUserImage();
    getUserName();
    emit(AccountLoadingState());

    getUserEmail();
    emit(AccountLoadingState());

    getUserPhone();
  }

//
  getUserImage() async {
    emit(AccountLoadingState());

    await FirebaseFirestore.instance.collection('users').doc(uid).get().then(
      (value) {
        image = value.get('image');

        log('IMAGE USER $image');
      },
    ).catchError((onError) {
      log('IMAGE USER ERROR');
    });
  }

//  (Methode) Get Phone Number
  getUserPhone() {
    emit(AccountLoadingState());
    //
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      phoneNumber = value.get('phone');
      //
      emit(AccountSuccessState());

      log('IMAGE$phoneNumber');
    }).catchError((onError) {
      log('Phone User ERROR');
    });
  }

//  (Methode) Get Username
  getUserName() async {
    //
    emit(AccountLoadingState());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      name = value.get('name');
      firstChar();
      //
      log('USERNAME $name');
    }).catchError((onError) {
      log('USERNAME ERROR');
    });
  }

//  (Methode) Get Email
  getUserEmail() {
    //
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      email = value.get('email');
      //
      log('IIIIIIIIIIII$email');
    }).catchError((onError) {
      log('EMAIL USER ERROR');
    });
  }

//  (Methode) Update User updateUserInformation
  updateUserInformation({String? newName, String? newPhoneNumber}) {
    updateName(uid: uid, newName: newName);
    updatePhoneNumber(uid: uid, newPhoneNumber: newPhoneNumber);
  }

//  (Methode) Update Phone Number
  updatePhoneNumber({String? uid, String? newPhoneNumber}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'phone': newPhoneNumber}).then((value) {
      log('UPDATE PHONE NUMBER SUCCESS');
    }).catchError((onError) {
      log('UPDATE PHONE NUMBER ERROR');
    });
  }

//  (Methode) Update Username
  updateName({String? uid, String? newName}) async {
    prefs = await SharedPreferences.getInstance();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'name': newName}).then(
      (value) {
        prefs!.setString('name', newName!);
      },
    );
  }

//  (Methode) Select Image from (gallery)
  Future<void> getImagePicker() async {
    ImagePicker picker = ImagePicker();
    file = await picker.pickImage(source: ImageSource.gallery);
    //start upload
    if (file != null) {
      imagePath = File(file!.path);
      selectImage = true;
      var refStoreg = FirebaseStorage.instance.ref("images/$uid");
      emit(AccountLoadingState());
      await refStoreg.putFile(imagePath!);
      var url = await refStoreg.getDownloadURL();

      saveUrlImage = url;
      emit(AccountSuccessState());
      log('IMAGE PATH :$url');

      //Success
    }
  }

//  (Methode) Send Image from gallery to Firestore
  sendImageFirestore() async {
    emit(AccountLoadingState());
    prefs = await SharedPreferences.getInstance();
    prefs!.setString('image', saveUrlImage!);
    log("sendImageShare + $saveUrlImage");
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'image': saveUrlImage}).then((value) {
      getData();
      log("get all data ");
      emit(AccountSuccessState());
    }).catchError((onError) {
      log('updateImage ERROR');
    });
  }

//  (Methode) Remove Image From Firestore and update
  removeImageFirestore() async {
    prefs = await SharedPreferences.getInstance();

    emit(AccountLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'image': ""}).then((value) {
      prefs!.setString('image', "").then((value) {
        getData();
      });

      emit(AccountSuccessState());
    }).catchError((onError) {
      log('updateImage ERROR');
    });
  }

//  (Methode) Get First Char from (name)
  void firstChar() {
    emit(AccountLoadingState());
    firstCharName = name![0];
    capitalChar();
    emit(AccountSuccessState());
  }

//  (Methode) Get Capital Char from (name)
  void capitalChar() {
    firstCharName = firstCharName!.toUpperCase();
  }
}
