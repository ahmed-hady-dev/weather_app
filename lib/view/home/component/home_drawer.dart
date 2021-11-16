import 'package:flutter/material.dart';
import 'map_row.dart';
import 'theme_row.dart';

import 'language_row.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: const <Widget>[
          ThemeRow(),
          Divider(height: 8.0),
          LanguageRow(),
          Divider(height: 8.0),
          MapRow(),
          Divider(height: 8.0),
        ],
      ),
    );
  }
}
