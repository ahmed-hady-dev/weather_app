// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/view/home/controller/home_cubit.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key, required this.cubit}) : super(key: key);
  final HomeCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Form(
        key: cubit.formKey,
        child: TextFormField(
          controller: cubit.searchController,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) {
              return 'field_empty'.tr();
            }
            return null;
          },
          onFieldSubmitted: (value) {
            if (cubit.formKey.currentState!.validate()) {
              cubit
                  .getWeatherByCityName(
                    cityName: cubit.searchController!.value.text.toString(),
                  )
                  .then((value) => cubit.searchController!.clear());
            }
          },
          decoration: InputDecoration(
            hintText: 'search_weather'.tr(),
            prefixIcon: const Icon(Icons.location_on_rounded),
            suffixIcon: cubit.searchController!.text.isEmpty
                ? const SizedBox()
                : IconButton(
                    onPressed: () => cubit.searchController!.clear(),
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
