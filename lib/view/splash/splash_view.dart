// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/core/permission_helper/permission_helper.dart';
import 'package:weather_app/view/fallback/fallback_view.dart';
import '../fallback/gps_off_view.dart';
import '../home/home_view.dart';

import '../../core/router/router.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _visible = false;
  Widget? startWidget;

  Future<void> _checkGps() async {
    bool isGpsOn = await geo.Geolocator.isLocationServiceEnabled();
    if (isGpsOn) {
      if (await PermissionHelper().hasLocationPermission()) {
        startWidget = const HomeView();
      } else {
        await PermissionHelper().requestLocationPermission();
      }
    } else {
      startWidget = const GPSOffView();
    }
  }

  @override
  void initState() {
    super.initState();
    _checkGps();
    Timer(const Duration(milliseconds: 1), () {
      setState(() {
        _visible = !_visible;
      });
    });
    Timer(const Duration(milliseconds: 2000), () {
      MagicRouter.navigateAndPopAll(startWidget ??
          FallbackView(
              buttonText: 'allow_permission'.tr(),
              onPressed: () async {
                if (await Permission.location.status ==
                    PermissionStatus.granted) {
                  MagicRouter.navigateAndPopAll(const SplashView());
                } else {
                  await Permission.location.request();
                  await openAppSettings();
                }
              },
              image: 'assets/images/access_denied.png',
              text: 'location_permission'.tr()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsetsDirectional.only(start: 64.0, end: 64.0),
        decoration:
            BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
        child: AnimatedOpacity(
            duration: const Duration(milliseconds: 2000),
            opacity: _visible ? 1.0 : 0.0,
            child: Image.asset('assets/images/splash_logo.png')),
      ),
    );
  }
}
