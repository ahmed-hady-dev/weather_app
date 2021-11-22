// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/router/router.dart';
import 'package:weather_app/view/splash/splash_view.dart';

class GPSOffView extends StatelessWidget {
  const GPSOffView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsetsDirectional.all(60),
          child: Image.asset('assets/images/access_denied.png'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Center(
            child: Text(
              'turn_gps'.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                MagicRouter.navigateAndPopAll(const SplashView());
              },
              child: Text(
                'retry'.tr(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            const SizedBox(width: 22),
            OutlinedButton(
              onPressed: () async {
                await Geolocator.openLocationSettings();
              },
              child: Text(
                'turn_gps_button'.tr(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        )
      ],
    ));
  }
}
