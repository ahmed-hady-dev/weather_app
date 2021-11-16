// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/router/router.dart';
import 'package:weather_app/view/map/map_view.dart';

class MapRow extends StatelessWidget {
  const MapRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "map".tr(),
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18.0),
          ),
          IconButton(
              onPressed: () {
                MagicRouter.pop();
                MagicRouter.navigateTo(const MapView());
              },
              icon: const Icon(
                Icons.place_rounded,
                size: 32.0,
              )),
        ],
      ),
    );
  }
}
