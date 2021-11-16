import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class WeatherIcon extends StatelessWidget {
  final String weatherIcon;

  const WeatherIcon({
    Key? key,
    required this.weatherIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.5,
      width: MediaQuery.of(context).size.width,
      child: Center(
          child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: 'https://openweathermap.org/img/wn/$weatherIcon@4x.png')),
    );
  }
}
