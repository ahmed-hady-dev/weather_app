import 'package:flutter/material.dart';

class CountryWidget extends StatelessWidget {
  final String countryName;
  const CountryWidget({
    Key? key,
    required this.countryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 16, top: 8.0),
      child: Text(
        countryName.toUpperCase(),
        softWrap: true,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
