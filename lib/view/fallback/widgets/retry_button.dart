import 'package:flutter/material.dart';

class RetryButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const RetryButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
