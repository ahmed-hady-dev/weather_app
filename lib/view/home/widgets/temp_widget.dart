import 'package:flutter/material.dart';

class TempWidget extends StatelessWidget {
  final String temp;

  const TempWidget({
    Key? key,
    this.temp = '18',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$temp°C",
      softWrap: true,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.headline6!.copyWith(
          letterSpacing: 1.5, fontSize: 52.0, fontWeight: FontWeight.w700),
    );
  }
}
