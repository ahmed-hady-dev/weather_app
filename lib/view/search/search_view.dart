// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/core/router/router.dart';
import 'package:weather_app/view/home/controller/home_cubit.dart';
import 'package:weather_app/view/search/widgets/search_button.dart';
import 'package:weather_app/view/search/widgets/search_field.dart';

import 'component/loading.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            final cubit = HomeCubit.get(context);
            if (state is GetDataFailed) {
              Fluttertoast.showToast(
                msg: cubit.errorMap!['message'],
              );
              MagicRouter.pop();
            }
            if (state is GetDataSuccess) {
              Fluttertoast.showToast(
                msg: 'search_success'.tr(),
              );
              MagicRouter.pop();
            }
          },
          builder: (context, state) {
            final cubit = HomeCubit.get(context);
            return Column(
              children: <Widget>[
                SearchField(cubit: cubit),
                const Spacer(),
                state is GetDataLoading
                    ? const Loading()
                    : SearchButton(
                        onPressed: () {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit
                                .getWeatherByCityName(
                                  cityName: cubit.searchController!.value.text
                                      .toString(),
                                )
                                .then(
                                    (value) => cubit.searchController!.clear());
                          }
                        },
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
