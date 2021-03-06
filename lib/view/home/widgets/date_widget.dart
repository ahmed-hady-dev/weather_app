// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDay = DateFormat.EEEE().format(DateTime.now());
    if (context.locale.languageCode == 'ar') {
      switch (formattedDay.toLowerCase()) {
        case 'saturday':
          formattedDay = "السبت";
          break;
        case 'sunday':
          formattedDay = "الأحد";
          break;
        case 'monday':
          formattedDay = "الإثنين";
          break;
        case 'tuesday':
          formattedDay = "الثلاثاء";
          break;
        case 'wednesday':
          formattedDay = "الأربعاء";
          break;
        case 'thursday':
          formattedDay = "الخميس";
          break;
        case 'friday':
          formattedDay = "الجمعة";
          break;
        default:
      }
    }
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        String formattedTime = DateFormat.jm().format(DateTime.now());
        return RichText(
          text: TextSpan(
            text: '${formattedDay.toUpperCase()}   ',
            style: Theme.of(context).textTheme.headline6,
            children: [
              TextSpan(
                  text: formattedTime,
                  style: Theme.of(context).textTheme.headline6),
            ],
          ),
        );
      },
    );
  }
}
