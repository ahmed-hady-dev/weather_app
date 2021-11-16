import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:nil/nil.dart';
import 'core/locationHelper/location_helper.dart';
import 'core/theme/theme.dart';
import 'core/theme/theme_cubit.dart';
import 'view/fallback/fallback_view.dart';
import 'view/home/home_view.dart';

import 'core/blocObserver/bloc_observer.dart';
import 'core/cacheHelper/cache_helper.dart';
import 'core/dioHelper/dio_helper.dart';
import 'core/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //===============================================================
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  //===============================================================
  await EasyLocalization.ensureInitialized();
  await LocationHelper.getCurrentLocation();
  //===============================================================
  await CacheHelper.init();
  await CacheHelper.get(key: 'isDark') ??
      await CacheHelper.saveData(key: 'isDark', value: false);
  bool? isDark = CacheHelper.get(key: 'isDark');
  //===============================================================
  runApp(EasyLocalization(
    child: MyApp(isDark: isDark!),
    path: 'assets/translation',
    supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
    fallbackLocale: const Locale('en', 'US'),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isDark}) : super(key: key);
  final bool isDark;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ThemeCubit()..changeTheme(themeModeFromCache: isDark),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          var themeCubit = ThemeCubit.get(context).isDark;
          return MaterialApp(
            title: 'Weather App',
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            onGenerateRoute: onGenerateRoute,
            themeMode: themeCubit ? ThemeMode.dark : ThemeMode.light,
            theme: lightTheme(context),
            darkTheme: darkTheme(context),
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            home: OfflineBuilder(
              connectivityBuilder: (BuildContext context,
                  ConnectivityResult connectivity, Widget child) {
                final bool connected = connectivity == ConnectivityResult.none;
                if (connected) {
                  return FallbackView(
                    image: 'assets/images/error.png',
                    text: 'internet_error'.tr(),
                  );
                }
                return const HomeView();
              },
              child: nil,
            ),
          );
        },
      ),
    );
  }
}
