import 'package:flutter/material.dart';

class FallbackView extends StatelessWidget {
  const FallbackView(
      {Key? key,
      required this.image,
      required this.text,
      required this.onPressed,
      required this.buttonText})
      : super(key: key);
  final String image;
  final String text;
  final String buttonText;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsetsDirectional.all(60),
          child: Image.asset(image),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        OutlinedButton(
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: Theme.of(context).textTheme.bodyText1,
            ))
      ],
    ));
  }
}
