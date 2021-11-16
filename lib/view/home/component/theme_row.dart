// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/cacheHelper/cache_helper.dart';
import 'package:weather_app/core/theme/theme_cubit.dart';
import 'package:weather_app/view/home/controller/home_cubit.dart';

class ThemeRow extends StatelessWidget {
  const ThemeRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "dark_theme".tr(),
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18.0),
          ),
          CupertinoSwitch(
            activeColor: Colors.black26,
            thumbColor: Colors.black,
            value: CacheHelper.get(key: 'isDark'),
            onChanged: (value) {
              HomeCubit.get(context).changeNotificationToggle(value: value);
              ThemeCubit.get(context).changeTheme();
            },
          ),
        ],
      ),
    );
  }
}
