import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({Key? key}) : super(key: key);

  @override
  _DateWidgetState createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 10)),
      builder: (context, snapshot) {
        final DateTime now = DateTime.now();
        String formattedDay = DateFormat.EEEE().format(now);
        String formattedTime = DateFormat.jm().format(now);
        return Padding(
          padding: const EdgeInsetsDirectional.all(8.0),
          child: RichText(
            text: TextSpan(
              text: '${formattedDay.toUpperCase()}   ',
              style: Theme.of(context).textTheme.headline6,
              children: [
                TextSpan(
                    text: formattedTime,
                    style: Theme.of(context).textTheme.headline6),
              ],
            ),
          ),
        );
      },
    );
  }
}
