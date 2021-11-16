import 'package:flutter/cupertino.dart';

class Loading extends StatelessWidget {
  const Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 48.0),
      child: CupertinoActivityIndicator(
        animating: true,
        radius: 12.0,
      ),
    );
  }
}
