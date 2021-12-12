import 'package:flutter/material.dart';

class CityWidget extends StatelessWidget {
  final String cityName;

  const CityWidget({
    Key? key,
    required this.cityName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(8.0),
      child: Text(
        cityName.toUpperCase(),
        softWrap: true,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style:
            Theme.of(context).textTheme.headline6!.copyWith(letterSpacing: 1.5),
      ),
    );
  }
}
