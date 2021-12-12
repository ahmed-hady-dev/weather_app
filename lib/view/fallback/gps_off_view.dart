// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:weather_app/view/fallback/component/gps_off_portrait_layout.dart';
import 'package:weather_app/core/responsive_helper/responsive_layout.dart';

import 'component/gps_off_landscape_layout.dart';

class GPSOffView extends StatelessWidget {
  const GPSOffView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveLayout(
        mobilePortrait: GPSOffPortraitLayout(),
        mobileLandscape: GPSOffLandscapeLayout(),
      ),
    );
  }
}
