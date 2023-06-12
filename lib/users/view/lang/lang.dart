import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:snack/snack.dart';

import '../../../utils/translate/translate.dart';

import '../home/home_view.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../widget/custem_buttom.dart';

class LangView extends StatefulWidget {
  const LangView({Key? key}) : super(key: key);
  @override
  State<LangView> createState() => _LangViewState();
}

class _LangViewState extends State<LangView> {
  @override
  Widget build(BuildContext context) {
    Get.put(TranslationController());

    var snackBarEN = SnackBar(
      content: const Text(AppString.theLanguageHasBeenChanged),
      backgroundColor: ColorManger.success,
    );
    var snackBarAR = SnackBar(
        content: const Text(AppStringAr.theLanguageHasBeenChanged),
        backgroundColor: ColorManger.success);

    TranslationController controllerLang = Get.find();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustemBottom(
                lable: AppString.arabic.tr,
                fontSize: 20,
                // fontWeight: FontWeight.bold,
                onTap: () {
                  controllerLang.changeLang('ar');
                  snackBarAR.show(context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const HomeView()),
                      (Route<dynamic> route) => false);
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustemBottom(
                lable: AppString.english,
                fontSize: 20,
                // fontWeight: FontWeight.bold,
                onTap: () {
                  controllerLang.changeLang('en');
                  snackBarEN.show(context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const HomeView()),
                      (Route<dynamic> route) => false);
                }),
          ),
        ],
      ),
    );
  }
}
