import 'package:flutter/material.dart';

class ErrorImage extends StatelessWidget {
  const ErrorImage({
    Key? key,
    required this.image,
  }) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.all(60),
      child: Image.asset(image),
    );
  }
}
