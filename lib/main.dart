import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'blocks/rates/dolar_bloc.dart';
import 'generated/l10n.dart';
// import 'repository/dolarsi_repository.dart';
import 'repository/dolarhoy_repository.dart';
import 'screens/app_screen.dart';
import 'theme/theme_rates.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // bool isDarkTheme =
    //     MediaQuery.of(context).platformBrightness == Brightness.dark;
    return AdaptiveTheme(
        light: kLightTheme,
        dark: kDarkTheme,
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp(
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                debugShowCheckedModeBanner: false,
                title: 'Dollar blue',
                theme: theme,
                darkTheme: darkTheme,
                home: BlocProvider(
                  create: (context) =>
                      // RatesBloc(DolarsiRepository())..add(FetchRatesEvent()),
                      RatesBloc(DolarhoyRepository())..add(FetchRatesEvent()),
                  child: const MyHomePage(),
                )));
  }
}
