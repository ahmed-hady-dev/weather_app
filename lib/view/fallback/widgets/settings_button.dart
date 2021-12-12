// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        await Geolocator.openLocationSettings();
      },
      child: Text(
        'turn_gps_button'.tr(),
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
