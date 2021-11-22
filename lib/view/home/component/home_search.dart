// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/cacheHelper/cache_helper.dart';
import 'package:weather_app/core/router/router.dart';
import 'package:weather_app/view/home/controller/home_cubit.dart';
import 'package:weather_app/view/search/search_view.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'TextField',
      child: InkWell(
        onTap: () => MagicRouter.navigateTo(BlocProvider.value(
          value: cubit,
          child: const SearchView(),
        )),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: CacheHelper.get(key: 'isDark')
                ? Colors.grey.shade900
                : Colors.grey.shade300,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18.0),
          child: Center(child: Text('search'.tr())),
        ),
      ),
    );
  }
}
