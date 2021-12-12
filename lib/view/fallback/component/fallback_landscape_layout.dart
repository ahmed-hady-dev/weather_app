import 'package:flutter/material.dart';
import 'package:weather_app/view/fallback/widgets/error_text.dart';
import 'package:weather_app/view/fallback/widgets/retry_button.dart';

import '../widgets/error_image.dart';

class FallbackLandscapeLayout extends StatelessWidget {
  const FallbackLandscapeLayout(
      {Key? key,
      required this.image,
      required this.text,
      this.buttonText,
      this.onPressed,
      this.showButton = true})
      : super(key: key);
  final String image;
  final String text;
  final String? buttonText;
  final Function()? onPressed;
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: ErrorImage(image: image)),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ErrorText(text: text),
            if (showButton)
              RetryButton(
                text: buttonText!,
                onPressed: onPressed,
              )
          ],
        )),
      ],
    );
  }
}
