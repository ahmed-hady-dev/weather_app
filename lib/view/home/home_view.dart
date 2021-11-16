// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/view/home/controller/home_cubit.dart';
import 'package:weather_app/view/home/widgets/city_widget.dart';
import 'package:weather_app/view/home/widgets/country_widget.dart';
import 'package:weather_app/view/home/widgets/date_widget.dart';
import 'package:weather_app/view/home/widgets/info_widget.dart';
import 'package:weather_app/view/home/widgets/temp_widget.dart';
import 'package:weather_app/view/home/widgets/weather_icon.dart';
import 'package:weather_app/view/home/widgets/weather_state_widget.dart';

import 'component/home_drawer.dart';
import 'component/home_search.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider(
      create: (context) => HomeCubit()..getWeatherByLocation(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = HomeCubit.get(context);
          final model = cubit.model;
          return Scaffold(
            key: cubit.scaffoldKey,
            drawer: const HomeDrawer(),
            body: cubit.model == null ||
                    state is GetDataLoading ||
                    state is LocationLoading
                ? const LoadingWidget()
                : RefreshIndicator(
                    onRefresh: () async => await cubit.getWeatherByLocation(),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: [
                        Stack(
                          children: [
                            IconButton(
                                onPressed: () => cubit.scaffoldKey.currentState!
                                    .openDrawer(),
                                icon: const Icon(
                                  Icons.menu,
                                  size: 32.0,
                                )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    CityWidget(
                                        cityName: model!.name.toString()),
                                    CountryWidget(
                                        countryName:
                                            model.sys!.country.toString()),
                                    const DateWidget(),
                                  ],
                                ),
                                WeatherIcon(
                                    weatherIcon:
                                        model.weather![0]!.icon.toString()),
                                Column(
                                  children: <Widget>[
                                    TempWidget(
                                        temp: model.main!.temp!
                                            .toInt()
                                            .toString()),
                                    WeatherStateWidget(
                                        weatherState: model
                                            .weather![0]!.description
                                            .toString()),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InfoWidget(
                                          title: 'humidity'.tr(),
                                          subTitle:
                                              "${model.main!.humidity.toString()}%"),
                                      InfoWidget(
                                          title: 'wind'.tr(),
                                          subTitle: model.wind!.speed!
                                                  .floor()
                                                  .toString() +
                                              ' ' +
                                              'km'.tr()),
                                      InfoWidget(
                                          title: 'real_feel'.tr(),
                                          subTitle:
                                              "${model.main!.feelsLike!.floor().toString()}°C"),
                                    ],
                                  ),
                                ),
                                HomeSearch(cubit: cubit),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
          );
        },
      ),
    ));
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CupertinoActivityIndicator(
      animating: true,
      radius: 22.0,
    ));
  }
}
