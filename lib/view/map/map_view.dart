// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/core/router/router.dart';
import 'package:weather_app/view/home/controller/home_cubit.dart';

import '../../core/locationHelper/location_helper.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  static Position? position;
  final Completer<GoogleMapController> _mapController = Completer();
  Marker? marker;
  LatLng? updatedMarkerPosition;
  //===============================================================
  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
      target: LatLng(position!.latitude, position!.longitude),
      bearing: 0.0,
      tilt: 0.0,
      zoom: 17.0);
  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.getCurrentLocation().whenComplete(() {
      setState(() {});
    });
    marker = Marker(
      markerId: const MarkerId('id'),
      position: LatLng(position!.latitude, position!.longitude),
    );
    updatedMarkerPosition = LatLng(position!.latitude, position!.longitude);
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
    setState(() {
      marker = Marker(
          markerId: const MarkerId('id'),
          position: LatLng(position!.latitude, position!.longitude));
    });
  }

  Widget buildMap() {
    return GoogleMap(
      markers: marker == null ? {} : {marker!},
      onTap: (argument) {
        setState(() {
          marker = Marker(markerId: const MarkerId('id'), position: argument);
          updatedMarkerPosition = argument;
        });
      },
      initialCameraPosition: _myCurrentLocationCameraPosition,
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getMyCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = HomeCubit.get(context);
          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                position != null
                    ? buildMap()
                    : const Center(
                        child: CupertinoActivityIndicator(
                            animating: true, radius: 24.0)),
                MagicRouter.currentContext!.locale.languageCode == 'en'
                    ? buildBackButton(left: 8.0)
                    : buildBackButton(right: 8.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    height: 60.0,
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        )),
                    child: TextButton(
                      onPressed: () {
                        cubit.updateMarkerPosition(
                            updatedMarkerPosition: updatedMarkerPosition!);
                        MagicRouter.pop();
                      },
                      child: Text(
                        'choose_location'.tr(),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 8, 30),
              child: FloatingActionButton(
                onPressed: _goToMyCurrentLocation,
                child: const Icon(Icons.place, color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }

  Positioned buildBackButton({
    double? left,
    double? right,
  }) {
    return Positioned(
        top: 8.0,
        left: left,
        right: right,
        child: IconButton(
            onPressed: () => MagicRouter.pop(),
            icon: CircleAvatar(
              backgroundColor: Colors.grey[400],
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
            )));
  }
}
