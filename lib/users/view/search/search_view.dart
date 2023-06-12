import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../view_model/search/cubit.dart';
import '../../view_model/search/state.dart';
import '../details_prodect/details_view.dart';
import '../resources/color_manager.dart';
import '../resources/size_confige.dart';

// ignore: must_be_immutable
class SearchItem extends StatefulWidget {
  String? label = '';
  String? image = '';
  String? price = '';
  String? decoration = '';
  SearchItem({Key? key}) : super(key: key);

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit()..getSearchData(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          searchProdect(String value) {
            setState(() {
              context.read<SearchCubit>().disDataAll = context
                  .read<SearchCubit>()
                  .dataAll
                  .where((element) => element.title!
                      .toLowerCase()
                      .contains(value.toLowerCase()))
                  .toList();
            });
          }

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: ColorManger.grey,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      onChanged: (value) => searchProdect(value),
                      cursorHeight: 25,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: 'Search Here...'),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize! * 50,
                    child: ListView.builder(
                      itemCount: context.read<SearchCubit>().disDataAll.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) => DetailsView(
                                    descrption: context
                                        .read<SearchCubit>()
                                        .dataAll[index]
                                        .decoration
                                        .toString(),
                                    price: context
                                        .read<SearchCubit>()
                                        .dataAll[index]
                                        .price
                                        .toString(),
                                    title: context
                                        .read<SearchCubit>()
                                        .dataAll[index]
                                        .title
                                        .toString(),
                                    image: context
                                        .read<SearchCubit>()
                                        .dataAll[index]
                                        .image
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Image(
                                image: NetworkImage(
                                  context
                                      .read<SearchCubit>()
                                      .disDataAll[index]
                                      .image
                                      .toString(),
                                ),
                              ),
                              title: Text(
                                context
                                    .read<SearchCubit>()
                                    .disDataAll[index]
                                    .title
                                    .toString(),
                              ),
                              trailing: Text(
                                  ' \$${context.read<SearchCubit>().dataAll[index].price.toString()}'),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
