import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../view_model/image_appbar/cubit.dart';
import '../../../../view_model/image_appbar/states.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/size_confige.dart';

class ImageAppbar extends StatelessWidget {
  const ImageAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9),
      child: BlocProvider(
        create: (context) => ImageAppBarCubit()
          ..getImage()
          ..getImageAppBarData(),
        child: BlocConsumer<ImageAppBarCubit, ImageAppBarStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ImageAppBarLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ImageAppBarSuccessState) {
              return CircleAvatar(
                backgroundColor: ColorManger.primary,
                radius: SizeConfig.defaultSize! / 0.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CircleAvatar(
                    radius: SizeConfig.defaultSize! / 0.6,
                    backgroundColor: ColorManger.grey,
                    child: context.read<ImageAppBarCubit>().image == ""
                        ? Center(
                            child: Text(
                              context
                                  .read<ImageAppBarCubit>()
                                  .firstCharName
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWhightManager.bold,
                                  fontSize: SizeConfig.defaultSize! / 0.5),
                            ),
                          )
                        : Center(
                            child: Image(
                              image: NetworkImage(
                                context
                                    .read<ImageAppBarCubit>()
                                    .image
                                    .toString(),
                              ),
                            ),
                          ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
