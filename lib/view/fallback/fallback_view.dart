import 'package:flutter/material.dart';
import 'package:weather_app/core/responsive_helper/responsive_layout.dart';

import 'component/fallback_landscape_layout.dart';
import 'component/fallback_portrait_layout.dart';

class FallbackView extends StatelessWidget {
  const FallbackView(
      {Key? key,
      required this.image,
      required this.text,
      this.onPressed,
      this.buttonText,
      this.showButton = true})
      : super(key: key);
  final String image;
  final String text;
  final String? buttonText;
  final Function()? onPressed;
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobilePortrait: FallbackPortraitLayout(
          text: text,
          image: image,
          onPressed: onPressed,
          showButton: showButton,
          buttonText: buttonText,
        ),
        mobileLandscape: FallbackLandscapeLayout(
          text: text,
          image: image,
          onPressed: onPressed,
          showButton: showButton,
          buttonText: buttonText,
        ),
      ),
    );
  }
}
// Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   crossAxisAlignment: CrossAxisAlignment.center,
//   children: [
//     Container(
//       margin: const EdgeInsetsDirectional.all(60),
//       child: Image.asset(image),
//     ),
//     Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
//       child: Center(
//         child: Text(
//           text,
//           textAlign: TextAlign.center,
//           style: Theme
//               .of(context)
//               .textTheme
//               .headline6,
//         ),
//       ),
//     ),
//     if (showButton)
//       OutlinedButton(
//           onPressed: onPressed,
//           child: Text(
//             buttonText!,
//             style: Theme
//                 .of(context)
//                 .textTheme
//                 .bodyText1,
//           )),
//   ],
// )
