import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../view_model/theme/cubit.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/strings_manager.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  AppString.privacyPolicy.tr,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWhightManager.bold,
                  ),
                ),
                const SizedBox(height: 12),
                RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: AppString.privacyPolicyDescription.tr,
                        style: TextStyle(
                            color: theme.isDark
                                ? ColorManger.white
                                : ColorManger.black,
                            fontSize: FontSize.s18)),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
