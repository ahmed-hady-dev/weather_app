import 'package:flutter/material.dart';
import 'package:weather_app/constants/constants.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout(
      {Key? key, required this.mobileBody, this.tabletBody, this.desktopBody})
      : super(key: key);
  final Widget mobileBody;
  final Widget? tabletBody;
  final Widget? desktopBody;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < kTabletBreakPoint) {
        return mobileBody;
      } else if (constraints.maxWidth >= kTabletBreakPoint &&
          constraints.maxWidth < kDesktopBreakPoint) {
        return tabletBody ?? mobileBody;
      } else {
        return desktopBody ?? mobileBody;
      }
    });
  }
}
