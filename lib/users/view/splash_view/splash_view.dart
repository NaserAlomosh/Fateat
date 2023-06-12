import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main_sign_in_up/main_sign.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/size_confige.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  _startDelay() {
    _timer = Timer(const Duration(seconds: 4), _goNext);
  }

  _goNext() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignInView()));
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              systemNavigationBarColor: ColorManger.primary),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: ColorManger.primary,
        body: Center(
          child: SizedBox(
            height: SizeConfig.defaultSize! * 20,
            width: SizeConfig.defaultSize! * 20,
            child: const Image(
              image: AssetImage(ImageAsset.splashLogo),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
