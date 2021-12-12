// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      child: Container(
        color: Colors.red,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          'offline_toast'.tr(),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: Theme.of(context)
              .textTheme
              .overline!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
