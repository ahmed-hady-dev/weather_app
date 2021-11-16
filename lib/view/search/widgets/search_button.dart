// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final Function() onPressed;
  const SearchButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.search_rounded),
        label: Text('search_short'.tr()),
        style: OutlinedButton.styleFrom(
          shape: const StadiumBorder(),
          enableFeedback: true,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
}
