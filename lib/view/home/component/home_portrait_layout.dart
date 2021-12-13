// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/view/home/controller/home_cubit.dart';
import 'package:weather_app/view/home/widgets/city_widget.dart';
import 'package:weather_app/view/home/widgets/country_widget.dart';
import 'package:weather_app/view/home/widgets/date_widget.dart';
import 'package:weather_app/view/home/widgets/info_widget.dart';
import 'package:weather_app/view/home/widgets/offline_banner.dart';
import 'package:weather_app/view/home/widgets/temp_widget.dart';
import 'package:weather_app/view/home/widgets/weather_icon.dart';
import 'package:weather_app/view/home/widgets/weather_state_widget.dart';

import '../widgets/drawer_button.dart';
import 'home_search.dart';

class HomePortraitLayout extends StatelessWidget {
  const HomePortraitLayout({Key? key, required this.cubit}) : super(key: key);
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    final model = cubit.model;
    return Stack(
      children: [
        DrawerButton(onPressed: cubit.scaffoldKey.currentState!.openDrawer),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    CityWidget(cityName: model!.name.toString()),
                    CountryWidget(countryName: model.sys!.country.toString()),
                    const DateWidget(),
                  ],
                ),
              ),
              Expanded(
                  flex: 6,
                  child: WeatherIcon(
                      weatherIcon: model.weather![0]!.icon.toString())),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TempWidget(temp: model.main!.temp!.toInt().toString()),
                    WeatherStateWidget(
                        weatherState:
                            model.weather![0]!.description.toString()),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoWidget(
                          title: 'humidity'.tr(),
                          subTitle: "${model.main!.humidity.toString()}%"),
                      InfoWidget(
                          title: 'wind'.tr(),
                          subTitle: model.wind!.speed!.floor().toString() +
                              ' ' +
                              'km'.tr()),
                      InfoWidget(
                          title: 'real_feel'.tr(),
                          subTitle:
                              model.main!.feelsLike!.floor().toString() + "°C"),
                    ],
                  ),
                ),
              ),
              const HomeSearch(),
            ],
          ),
        ),
        const OfflineBanner(),
      ],
    );
  }
}
