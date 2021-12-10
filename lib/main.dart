// ignore_for_file: unused_import

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nil/nil.dart';
import 'package:weather_app/view/splash/splash_view.dart';
import 'view/home/controller/home_cubit.dart';
import 'core/locationHelper/location_helper.dart';
import 'core/theme/theme.dart';
import 'core/theme/theme_cubit.dart';
import 'view/fallback/fallback_view.dart';

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

class MyApp extends StatefulWidget {
  const MyApp({Key? key, this.isDark}) : super(key: key);
  final bool? isDark;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  ThemeCubit()..changeTheme(themeModeFromCache: widget.isDark)),
          BlocProvider(
            create: (context) => HomeCubit(),
          ),
        ],
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
              home: const SplashView(),
            );
          },
        ));
  }
}
