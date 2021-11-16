import 'package:flutter/material.dart';

class FallbackWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 56),
          child: Container(
            margin: const EdgeInsetsDirectional.all(60),
            child: Image.asset('assets/images/access_denied.png'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Center(
            child: Text(
              'Please make sure that location permission is allowed',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        )
      ],
    );
  }
}
