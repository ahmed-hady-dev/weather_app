// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/view/home/controller/home_cubit.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Positioned(
          bottom: 0.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutQuart,
            color: Colors.red,
            height: HomeCubit.get(context).isConnected ? 0 : 24,
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
      },
    );
  }
}
