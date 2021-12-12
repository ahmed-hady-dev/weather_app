// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/components/loading_widget.dart';
import 'package:weather_app/core/router/router.dart';
import 'package:weather_app/view/fallback/fallback_view.dart';
import 'package:weather_app/view/home/component/home_landscape_layout.dart';
import 'package:weather_app/view/home/component/home_portrait_layout.dart';
import 'package:weather_app/view/home/controller/home_cubit.dart';
import 'package:weather_app/core/responsive_helper/responsive_layout.dart';
import 'package:weather_app/view/splash/splash_view.dart';
import 'widgets/home_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).getCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) async {
          final cubit = HomeCubit.get(context);
          if (cubit.position == null) {
            MagicRouter.navigateAndPopAll(FallbackView(
                buttonText: 'refresh'.tr(),
                onPressed: () =>
                    MagicRouter.navigateAndPopAll(const SplashView()),
                image: 'assets/images/error.png',
                text: 'error'.tr()));
          }
          if (state is LocationSuccess ||
              state is UpdateLanguage ||
              (state is ConnectivityOnlineState && cubit.model == null)) {
            if (cubit.isConnected) {
              cubit.getWeatherByLocation(
                  lat: cubit.position!.latitude,
                  lon: cubit.position!.longitude);
            }
          }
          if (state is UpdatedMarker) {
            cubit.getWeatherByLocation(
                lat: state.updatedMarkerPosition!.latitude,
                lon: state.updatedMarkerPosition!.longitude);
          }
        },
        builder: (context, state) {
          final cubit = HomeCubit.get(context);
          if (!cubit.isConnected && cubit.model == null) {
            return FallbackView(
              image: 'assets/images/error.png',
              text: 'internet_error'.tr(),
              buttonText: 'refresh'.tr(),
              onPressed: () =>
                  MagicRouter.navigateAndPopAll(const SplashView()),
            );
          }
          if (cubit.model == null) {
            return const LoadingWidget();
          }
          return Scaffold(
            key: cubit.scaffoldKey,
            drawer: const HomeDrawer(),
            body: ResponsiveLayout(
              mobilePortrait: HomePortraitLayout(cubit: cubit),
              mobileLandscape: HomeLandscapeLayout(cubit: cubit),
            ),
          );
        },
      ),
    );
  }
}
