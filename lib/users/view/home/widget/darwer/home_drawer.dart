import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../view_model/drawer_home/cubit.dart';
import '../../../../view_model/drawer_home/states.dart';
import '../../../../view_model/log_out/cubit.dart';
import '../../../../view_model/log_out/state.dart';
import '../../../account/account_view.dart';
import '../../../help/help_view.dart';
import '../../../history_page/history_view.dart';
import '../../../main_sign_in_up/main_sign.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/size_confige.dart';
import '../../../resources/strings_manager.dart';
import '../../../ruta_us/ruta.dart';
import '../../../settings_page/settings_account.dart';
import '../../privacy_policy/privacy_policy_view.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DrawerCubit()..getDrawerData(),
      child: Drawer(
        child: ListView(
          children: [
            BlocConsumer<DrawerCubit, DrawerStates>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is DrawerLoadingState) {
                  return DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: const Alignment(0, 3),
                        colors: [
                          ColorManger.primary,
                          ColorManger.primary.withOpacity(0.6),
                        ],
                        tileMode: TileMode.mirror,
                      ),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: const Alignment(0, 3),
                        colors: [
                          ColorManger.primary,
                          ColorManger.primary.withOpacity(0.6),
                        ],
                        tileMode: TileMode.mirror,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManger.black.withOpacity(0.8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: ColorManger.grey,
                          radius: 45,
                          child: context.read<DrawerCubit>().image == ""
                              ? Center(
                                  child: Text(
                                    context
                                        .read<DrawerCubit>()
                                        .firstCharName
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: SizeConfig.defaultSize! * 7,
                                      fontWeight: FontWhightManager.bold,
                                      color: ColorManger.white,
                                    ),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image(
                                    image: NetworkImage(
                                      context
                                          .read<DrawerCubit>()
                                          .image
                                          .toString(),
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          context.read<DrawerCubit>().name.toString(),
                          style: TextStyle(
                            color: ColorManger.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(AppString.home.tr),
              hoverColor: ColorManger.primary,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(AppString.account.tr),
              hoverColor: ColorManger.primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AccountView()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: Text(AppString.historyOrder.tr),
              hoverColor: ColorManger.primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryView()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(AppString.settings.tr),
              hoverColor: ColorManger.primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsView()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.event_available),
              title: Text(AppString.rutaUs.tr),
              hoverColor: ColorManger.primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RutaView()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: Text(AppString.help.tr),
              hoverColor: ColorManger.primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpView()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: Text(AppString.privacyPolicy.tr),
              hoverColor: ColorManger.primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyView()),
                );
              },
            ),
            SizedBox(height: SizeConfig.screenHeight! / 4.1),
            BlocProvider(
              create: (context) => LogOutCubit(),
              child: BlocConsumer<LogOutCubit, LogOutStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is LogOutLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListTile(
                      leading: const Icon(
                        Icons.logout,
                        color: ColorManger.primary,
                      ),
                      title: Text(AppString.logOut.tr),
                      hoverColor: ColorManger.primary,
                      onTap: () {
                        context.read<LogOutCubit>().getLogOutAccount();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const SignInView()),
                            (Route<dynamic> route) => false);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
