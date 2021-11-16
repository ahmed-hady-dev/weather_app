import 'package:flutter/material.dart';

class WeatherStateWidget extends StatelessWidget {
  final String weatherState;
  const WeatherStateWidget({
    Key? key,
    this.weatherState = 'Sunny',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(8.0),
      child: Text(
        weatherState.toUpperCase(),
        softWrap: true,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
