// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/core/connectivity_helper/connectivity_helper.dart';
import 'package:weather_app/core/dioHelper/dio_helper.dart';
import 'package:weather_app/core/locationHelper/location_helper.dart';
import 'package:weather_app/core/router/router.dart';
import 'package:weather_app/view/home/model/weather_model.dart';

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
  bool themeToggle = true;
  late bool isConnected;
  StreamController<ConnectivityStatus> connectivityStream =
      ConnectivityHelper().connectionStatusController;

  //===============================================================
  @override
  Future<void> close() {
    searchController!.dispose();
    connectivityStream.close();
    return super.close();
  }

  //===============================================================
  changeThemeToggle({required bool value}) {
    themeToggle = value;
    emit(ChangeThemeToggleState());
  }

  //===============================================================
  Future<void> checkConnectivity() async {
    connectivityStream.stream.asBroadcastStream().listen((status) {
      if (status == ConnectivityStatus.offline) {
        isConnected = false;
        emit(ConnectivityOfflineState());
      } else {
        isConnected = true;
        emit(ConnectivityOnlineState());
      }
    });
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
  updateLang() {
    emit(UpdateLanguage());
  }

  //===============================================================

  updateMarkerPosition({required LatLng updatedMarkerPosition}) async {
    emit(UpdatedMarker(updatedMarkerPosition: updatedMarkerPosition));
  }

  //===============================================================
  Future<void> getWeatherByLocation(
      {required double lat, required double lon}) async {
    emit(GetDataLoading());
    final response = await DioHelper.getData(url: 'weather', query: {
      'appid': weatherApiKey,
      'units': 'metric',
      'lat': lat,
      'lon': lon,
      'lang':
          MagicRouter.currentContext!.locale.languageCode == 'en' ? 'en' : 'ar'
    });
    try {
      model = WeatherModel.fromJson(response.data);
      emit(GetDataSuccess());
    } on DioError catch (e) {
      print(e.toString());
      if (e.type == DioErrorType.other) {
        print(e.toString());
      }
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
