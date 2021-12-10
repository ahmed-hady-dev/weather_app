import 'package:flutter/material.dart';

class InfoBannerActionsFb1 extends StatelessWidget {
  final Icon icon;
  final Color primaryColor;
  final List<TextButton> actions;
  final String text;

  const InfoBannerActionsFb1(
      {required this.icon,
      required this.actions,
      required this.text,
      this.primaryColor = Colors.blue,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialBanner(
        content: Text(
          text,
          style: TextStyle(color: primaryColor),
        ),
        leading: CircleAvatar(
          child: icon,
          backgroundColor: primaryColor,
        ),
        actions: actions,
      ),
    );
  }
}
