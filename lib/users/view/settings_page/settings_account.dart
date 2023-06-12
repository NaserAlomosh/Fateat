import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../view_model/account/cubit.dart';
import '../../view_model/account/state.dart';
import '../../view_model/theme/cubit.dart';
import '../account/account_view.dart';
import '../home/widget/image_appbar/image_appbar.dart';
import '../lang/lang.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool? swich;
  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);
    return BlocProvider(
      create: (context) => AccountCubit()..getData(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close)),
            iconTheme: IconThemeData(
              color: theme.isDark ? ColorManger.white : ColorManger.black,
            ),
            backgroundColor: theme.isDark
                ? ColorManger.black.withOpacity(0.68)
                : ColorManger.grey.withOpacity(0.08),
            elevation: 0,
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountView()),
                  );
                },
                child: const ImageAppbar(),
              ),
            ],
          ),
          body: BlocConsumer<AccountCubit, AccountState>(
            listener: (context, state) {},
            builder: (context, state) {
              return SettingsList(
                sections: [
                  SettingsSection(
                    title: Text(
                      AppString.application.tr,
                      style: const TextStyle(color: ColorManger.primary),
                    ),
                    tiles: <SettingsTile>[
                      SettingsTile.navigation(
                        leading: const Icon(Icons.language),
                        title: Text(AppString.language.tr),
                        value: Text(AppString.english.tr),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                        onPressed: (_) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LangView()),
                          );
                        },
                      ),
                      SettingsTile.switchTile(
                        onToggle: (v) {
                          setState(() {
                            swich = v;
                            theme.changeTheme();
                          });
                        },
                        initialValue: swich,
                        leading: const Icon(
                          Icons.format_paint,
                          size: 20,
                        ),
                        title: Text(AppString.changeTheme.tr),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppString.account.tr,
                          style: const TextStyle(color: ColorManger.primary),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => const AccountView()));
                            },
                            child: Text(
                              AppString.edit.tr,
                              style:
                                  const TextStyle(color: ColorManger.primary),
                            ))
                      ],
                    ),
                    tiles: <SettingsTile>[
                      SettingsTile.navigation(
                        onPressed: (_) {},
                        leading: const Icon(
                          Icons.person_outline,
                          size: 20,
                        ),
                        title: Text(AppString.username.tr),
                        value:
                            Text(context.read<AccountCubit>().name.toString()),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      ),
                      SettingsTile.navigation(
                        leading: const Icon(Icons.email_outlined),
                        title: Text(AppString.email.tr),
                        value:
                            Text(context.read<AccountCubit>().email.toString()),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      ),
                      SettingsTile.navigation(
                        leading: const Icon(Icons.phone),
                        title: Text(AppString.phoneNumber.tr),
                        value: Text(context
                            .read<AccountCubit>()
                            .phoneNumber
                            .toString()),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
