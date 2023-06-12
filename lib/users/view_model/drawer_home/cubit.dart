import 'package:eatmore_app/users/view_model/drawer_home/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerCubit extends Cubit<DrawerStates> {
  DrawerCubit() : super(DrawerInitState());
  String? name;
  String? image;
  String? uid;
  SharedPreferences? prefe;
  String? firstCharName;

  getDrawerData() async {
    emit(DrawerLoadingState());
    prefe = await SharedPreferences.getInstance();
    uid = prefe!.getString('uid');
    image = prefe!.getString('image');
    name = prefe!.getString('name');
    firstCharName = prefe!.getString('FirstChar');
    if (prefe!.getString('image') != "") {
      image = prefe!.getString('image');
    }
    emit(DrawerSuccessState());
  }

//  (Methode) Get First Char from (name)

}
