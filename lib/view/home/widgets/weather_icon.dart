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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: MediaQuery.of(context).orientation == Orientation.landscape
            ? 1.5
            : 1.2,
        child: FadeInImage.memoryNetwork(
            fit: BoxFit.fitWidth,
            placeholder: kTransparentImage,
            image: 'https://openweathermap.org/img/wn/$weatherIcon@4x.png'),
      ),
    );
  }
}
