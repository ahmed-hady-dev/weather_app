import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const InfoWidget({
    Key? key,
    this.title = 'Humidity',
    this.subTitle = '94%',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          softWrap: true,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6,
        ),
        Text(
          subTitle,
          softWrap: true,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    ));
  }
}
