// ignore_for_file: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/router/router.dart';
import 'package:weather_app/view/fallback/widgets/error_text.dart';
import 'package:weather_app/view/fallback/widgets/retry_button.dart';
import 'package:weather_app/view/fallback/widgets/settings_button.dart';
import 'package:weather_app/view/splash/splash_view.dart';

import '../widgets/error_image.dart';

class GPSOffPortraitLayout extends StatelessWidget {
  const GPSOffPortraitLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ErrorImage(
          image: 'assets/images/access_denied.png',
        ),
        ErrorText(
          text: 'turn_gps'.tr(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RetryButton(
              text: 'retry'.tr(),
              onPressed: () {
                MagicRouter.navigateAndPopAll(const SplashView());
              },
            ),
            const SizedBox(width: 22),
            const SettingsButton(),
          ],
        )
      ],
    );
  }
}
