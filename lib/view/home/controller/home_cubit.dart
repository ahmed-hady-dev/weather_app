// ignore_for_file: implementation_imports

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/core/dioHelper/dio_helper.dart';
import 'package:weather_app/core/locationHelper/location_helper.dart';
import 'package:weather_app/core/router/router.dart';
import 'package:weather_app/view/home/model/weather_model.dart';
import 'package:easy_localization/src/public_ext.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
//===============================================================
  Position? position;
  WeatherModel? model;
  Map<String, dynamic>? errorMap;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController? searchController = TextEditingController();
  bool notificationToggle = true;
  //===============================================================
  changeNotificationToggle({required bool value}) {
    notificationToggle = value;
    emit(ChangeNotificationToggle());
  }
//===============================================================

  Future<Position?> getCurrentLocation() async {
    emit(LocationLoading());
    try {
      position = await LocationHelper.getCurrentLocation().whenComplete(() {});
      emit(LocationSuccess(position: position!));
      return position!;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(LocationError());
    }
  }

//===============================================================
  Future<void> getWeatherByLocation() async {
    emit(GetDataLoading());
    final currentPosition = await getCurrentLocation();
    final response = await DioHelper.getData(url: 'weather', query: {
      'appid': weatherApiKey,
      'units': 'metric',
      'lat': currentPosition!.latitude,
      'lon': currentPosition.longitude,
      'lang':
          MagicRouter.currentContext!.locale.languageCode == 'en' ? 'en' : 'ar'
    });
    try {
      model = WeatherModel.fromJson(response.data);
      emit(GetDataSuccess());
    } on DioError catch (e) {
      debugPrint(e.error.toString());
      emit(GetDataFailed());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(GetDataFailed());
    }
  }

  //===============================================================
  Future<void> getWeatherByCityName({required String cityName}) async {
    emit(GetDataLoading());
    final response = await DioHelper.getData(url: 'weather', query: {
      'appid': weatherApiKey,
      'units': 'metric',
      'q': cityName.trim().toLowerCase(),
      'lang':
          MagicRouter.currentContext!.locale.languageCode == 'en' ? 'en' : 'ar'
    });
    try {
      model = WeatherModel.fromJson(response.data);
      emit(GetDataSuccess());
    } on DioError catch (e) {
      debugPrint(e.error.toString());
      emit(GetDataFailed());
    } catch (e, s) {
      if (response.statusMessage != 'ok') {
        errorMap = response.data;
      }
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(GetDataFailed());
    }
  }
}
