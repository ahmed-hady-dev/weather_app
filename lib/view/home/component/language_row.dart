// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/router/router.dart';
import 'package:weather_app/view/splash/splash_view.dart';

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
                  MagicRouter.navigateAndPopAll(const SplashView());
                } else if (context.locale.languageCode == 'ar') {
                  context.setLocale(const Locale('en', 'US'));
                  MagicRouter.navigateAndPopAll(const SplashView());
                }
              },
              child: Text(
                  context.locale.languageCode == 'en' ? 'العربية' : 'English')),
        ],
      ),
    );
  }
}
