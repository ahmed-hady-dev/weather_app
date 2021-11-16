// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/view/home/controller/home_cubit.dart';

class LanguageRow extends StatelessWidget {
  const LanguageRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "lang".tr(),
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18.0),
          ),
          TextButton(
              onPressed: () {
                if (context.locale.languageCode == 'en') {
                  context.setLocale(const Locale('ar', 'EG'));
                  HomeCubit.get(context).updateLang();
                } else if (context.locale.languageCode == 'ar') {
                  context.setLocale(const Locale('en', 'US'));
                  HomeCubit.get(context).updateLang();
                }
              },
              child: Text(
                  context.locale.languageCode == 'en' ? 'العربية' : 'English')),
        ],
      ),
    );
  }
}
