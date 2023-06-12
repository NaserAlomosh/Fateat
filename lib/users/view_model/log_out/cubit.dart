import 'package:eatmore_app/users/view_model/log_out/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOutCubit extends Cubit<LogOutStates> {
  LogOutCubit() : super(LogOutInitState());
  SharedPreferences? prefe;
  getLogOutAccount() async {
    prefe = await SharedPreferences.getInstance();
    emit(LogOutLoadingState());
    await FirebaseAuth.instance.signOut().then((value) {
      prefe!.setString('name', "");
      prefe!.setString('image', "");
      prefe!.setString('FirstChar', "");
      prefe!.setString('email', "");
      emit(LogOutSuccessState());
    });
  }
}
