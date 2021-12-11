// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/cacheHelper/cache_helper.dart';
import 'package:weather_app/core/router/router.dart';
import 'package:weather_app/core/theme/theme_cubit.dart';
import 'package:weather_app/view/search/search_view.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(32.0),
            onTap: () => MagicRouter.navigateTo(const SearchView()),
            child: Ink(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: CacheHelper.get(key: 'isDark')
                    ? Colors.grey.shade900
                    : Colors.grey.shade300,
              ),
              child: Center(child: Text('search'.tr())),
            ),
          ),
        );
      },
    );
  }
}
