// ignore_for_file: implementation_imports

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/connectivity_helper/connectivity_helper.dart';
import 'package:weather_app/core/router/router.dart';
import 'package:weather_app/view/fallback/fallback_view.dart';
import 'package:weather_app/view/home/controller/home_cubit.dart';
import 'package:weather_app/view/home/widgets/city_widget.dart';
import 'package:weather_app/view/home/widgets/country_widget.dart';
import 'package:weather_app/view/home/widgets/date_widget.dart';
import 'package:weather_app/view/home/widgets/info_widget.dart';
import 'package:weather_app/view/home/widgets/temp_widget.dart';
import 'package:weather_app/view/home/widgets/weather_icon.dart';
import 'package:weather_app/view/home/widgets/weather_state_widget.dart';
import 'package:weather_app/view/splash/splash_view.dart';
import 'component/home_drawer.dart';
import 'component/home_search.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).getCurrentLocation().then((position) =>
        HomeCubit.get(context).getWeatherByLocation(
            lat: position!.latitude, lon: position.longitude));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: ConnectivityHelper().connectionStatusController.stream,
        builder: (context, AsyncSnapshot<ConnectivityStatus> status) {
          if (status.data == ConnectivityStatus.wifi ||
              status.data == ConnectivityStatus.cellular) {
            return BlocConsumer<HomeCubit, HomeState>(
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
                if (state is LocationSuccess || state is UpdateLanguage) {
                  if (status.data == ConnectivityStatus.wifi ||
                      status.data == ConnectivityStatus.cellular) {
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
                final model = cubit.model;

                if (cubit.model == null) {
                  return const LoadingWidget();
                }

                return Scaffold(
                  key: cubit.scaffoldKey,
                  drawer: const HomeDrawer(),
                  body: Stack(
                    children: [
                      IconButton(
                          onPressed: () =>
                              cubit.scaffoldKey.currentState!.openDrawer(),
                          icon: const Icon(
                            Icons.menu,
                            size: 32.0,
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              CityWidget(cityName: model!.name.toString()),
                              CountryWidget(
                                  countryName: model.sys!.country.toString()),
                              const DateWidget(),
                            ],
                          ),
                          WeatherIcon(
                              weatherIcon: model.weather![0]!.icon.toString()),
                          Column(
                            children: <Widget>[
                              TempWidget(
                                  temp: model.main!.temp!.toInt().toString()),
                              WeatherStateWidget(
                                  weatherState: model.weather![0]!.description
                                      .toString()),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InfoWidget(
                                    title: 'humidity'.tr(),
                                    subTitle:
                                        "${model.main!.humidity.toString()}%"),
                                InfoWidget(
                                    title: 'wind'.tr(),
                                    subTitle:
                                        model.wind!.speed!.floor().toString() +
                                            ' ' +
                                            'km'.tr()),
                                InfoWidget(
                                    title: 'real_feel'.tr(),
                                    subTitle: model.main!.feelsLike!
                                            .floor()
                                            .toString() +
                                        "°C"),
                              ],
                            ),
                          ),
                          const HomeSearch(),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }
          return FallbackView(
            image: 'assets/images/error.png',
            text: 'internet_error'.tr(),
            buttonText: 'retry',
            onPressed: () => MagicRouter.navigateAndPopAll(const SplashView()),
          );
        },
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: CupertinoActivityIndicator(
        animating: true,
        radius: 22.0,
      )),
    );
  }
}
