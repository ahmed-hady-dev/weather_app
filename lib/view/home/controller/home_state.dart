part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class ChangeNotificationToggle extends HomeState {}

class UpdateLanguage extends HomeState {}

class UpdatedMarker extends HomeState {
  final LatLng? updatedMarkerPosition;

  UpdatedMarker({required this.updatedMarkerPosition});
}
//===============================================================

class LocationLoading extends HomeState {}

class LocationSuccess extends HomeState {
  final Position position;

  LocationSuccess({required this.position});
}

class LocationError extends HomeState {}

//===============================================================
class GetDataLoading extends HomeState {}

class GetDataSuccess extends HomeState {}

class GetDataFailed extends HomeState {}
//===============================================================

class LocationIsEnabled extends HomeState {}

class LocationIsDisable extends HomeState {}
