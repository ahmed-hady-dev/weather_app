import 'package:flutter/material.dart';
import 'package:weather_app/view/fallback/widgets/error_image.dart';
import 'package:weather_app/view/fallback/widgets/error_text.dart';
import 'package:weather_app/view/fallback/widgets/retry_button.dart';

class FallbackPortraitLayout extends StatelessWidget {
  final String image;
  final String text;
  final String? buttonText;
  final Function()? onPressed;
  final bool showButton;

  const FallbackPortraitLayout(
      {Key? key,
      required this.image,
      required this.text,
      this.buttonText,
      this.onPressed,
      this.showButton = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ErrorImage(image: image),
        ErrorText(text: text),
        if (showButton)
          RetryButton(
            text: buttonText!,
            onPressed: onPressed,
          )
      ],
    );
  }
}
