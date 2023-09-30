import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocks/rates/dolar_bloc.dart';
import '../../generated/l10n.dart';
import '../../theme/theme_constants.dart';
import 'error_widget.dart';
import 'progress_indicator_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      BlocProvider.of<RatesBloc>(context).add(RefreshRatesEvent());
    });
    Future.microtask(() {
      final bool isDarkSysMode =
          MediaQuery.platformBrightnessOf(context) == Brightness.dark;
      isDarkSysMode
          ? AdaptiveTheme.of(context).setDark()
          : AdaptiveTheme.of(context).setLight();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatesBloc, RatesState>(
      builder: (context, state) {
        if (state is RatesInitial) {
          return const ProgressGoWest();
        } else if (state is RatesLoading) {
          return const ProgressGoWest();
        } else if (state is RatesError) {
          return ErrorMessageWidget(text: state.error);
        } else if (state is RatesLoaded) {
          final bool isDarkMode =
              AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
          return Scaffold(
            appBar: AppBar(
              // leading: GestureDetector(
              //   onTap: () {
              //     AdaptiveTheme.of(context).setSystem();
              //   },
              //   child: const Padding(
              //     padding: EdgeInsets.only(left: 10.0),
              //     child: Icon(
              //       size: 44,
              //       Icons.access_alarm,
              //     ),
              //   ),
              // ),
              title: const Text(
                'Dollar blue',
                //   Text(
                // MediaQuery.of(context).platformBrightness.toString(),
                style: AppTextStyle.dolarBlueBuy,
              ),
              actions: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        isDarkMode
                            ? AdaptiveTheme.of(context).setLight()
                            : AdaptiveTheme.of(context).setDark();
                      },
                      child: const ThemeIconWidget(),
                    )),
              ],
            ),
            body: const Center(
              child: CurrencyList(),
            ),
          );
        } else {
          return ErrorMessageWidget(text: S.of(context).unknown_error);
        }
      },
    );
  }
}

class CurrencyList extends StatelessWidget {
  const CurrencyList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatesBloc, RatesState>(builder: (context, state) {
      if (state is RatesLoaded) {
        return RefreshIndicator(
            onRefresh: () async {
              return BlocProvider.of<RatesBloc>(context)
                  .add(RefreshRatesEvent());
            },
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 5,
                  );
                },
                physics: const ClampingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: state.dollars.length,
                itemBuilder: (context, index) {
                  return CurrencyElement(
                    state: state,
                    index: index,
                  );
                },
              ),
            ));
      }
      return Container();
    });
  }
}

class CurrencyElement extends StatelessWidget {
  const CurrencyElement({super.key, required this.state, required this.index});
  final RatesLoaded state;
  final int index;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: isDarkMode ? AppColors.grey : AppColors.white,
            boxShadow: [
              BoxShadow(
                color: isDarkMode ? AppColors.black : AppColors.lgrey,
                blurRadius: 10,
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(state.dollars[index].name,
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(child: Text('Buy')),
                    Expanded(child: Text('Sell')),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    state.dollars[index].buy,
                    style: state.dollars[index].textStyleBuy,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    state.dollars[index].sell,
                    style: state.dollars[index].textStyleSell,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(state.dollars[index].date),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ThemeIconWidget extends StatefulWidget {
  const ThemeIconWidget({super.key});

  @override
  State<ThemeIconWidget> createState() => _ThemeIconWidgetState();
}

class _ThemeIconWidgetState extends State<ThemeIconWidget> {
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    return Icon(
      isDarkMode ? Icons.brightness_4 : Icons.brightness_2,
      size: 26.0,
    );
  }
}
