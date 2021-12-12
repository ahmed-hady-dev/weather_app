// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField(
      {Key? key,
      required this.searchController,
      required this.formKey,
      required this.search})
      : super(key: key);
  final TextEditingController searchController;
  final GlobalKey<FormState> formKey;
  final Function() search;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Form(
        key: formKey,
        child: TextFormField(
          controller: searchController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.go,
          validator: (value) {
            if (value!.isEmpty) {
              return 'field_empty'.tr();
            }
            return null;
          },
          onEditingComplete: search,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            hintText: 'search_weather'.tr(),
            prefixIcon: const Icon(Icons.location_on_rounded),
            suffixIcon: IconButton(
              onPressed: () => searchController.clear(),
              icon: const Icon(
                Icons.close_rounded,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
