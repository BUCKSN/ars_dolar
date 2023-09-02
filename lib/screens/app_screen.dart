import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocks/rates/dolar_bloc.dart';
import '../generated/l10n.dart';
// import '../repository/dolarhoy_repository.dart';
import '../theme/theme_constants.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

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
            // extendBodyBehindAppBar: true,
            appBar: AppBar(
              // leading: GestureDetector(
              //   onTap: () {
              //     _launchURL('https://t.me/WesternUArg', context);
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 10.0),
              //     child: Icon(
              //       size: 44,
              //       Icons.telegram_outlined,
              //     ),
              //   ),
              // ),
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

class CurrencyList extends StatefulWidget {
  const CurrencyList({
    super.key,
  });

  @override
  State<CurrencyList> createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(minutes: 5), (timer) {
      BlocProvider.of<RatesBloc>(context).add(RefreshRatesEvent());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AmbitoRepository().fetchAmbito();
    // print('fetchAmbito');
    // var test = DolarhoyRepository().fetchDolarhoy();
    // var test1 = DolarhoyRepository().getDolarhoy();
    // print('test $test');
    // print('test1 $test1');
    // final getAmbito = AmbitoRepository().getAmbito();

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

              // onRefresh: () async {
              //   return BlocProvider.of<RatesBloc>(context).add(RefreshRatesEvent());
              // },
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 5,
                  );
                },
                // physics: const BouncingScrollPhysics(
                // parent: AlwaysScrollableScrollPhysics()),

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

// class CurrencyElement extends StatelessWidget {
//   // const CurrencyElement({
//   //   super.key,
//   // });
//   CurrencyElement({Key? key, required this.state, required this.index}) : super(key: key);
//   final RatesLoaded state;
//   final int index;}
//   @override
//   Widget build(BuildContext context) {
//     // return BlocBuilder<RatesBloc, RatesState>(builder: (context, state) {
//     //   if (state is RatesLoaded) {
//         return
//       // }
//       // return Container();
//     });
//   }
// }
class CurrencyElement extends StatelessWidget {
  const CurrencyElement({super.key, required this.state, required this.index});
  final RatesLoaded state;
  final int index;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          15, 10, 15, 0), //.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: isDarkMode ? AppColors.grey : AppColors.white,
            boxShadow: [
              BoxShadow(
                color: isDarkMode ? AppColors.black : AppColors.lgrey,
                blurRadius: 20,
                // spreadRadius: 0.0
              )
            ]),
        // height: 100,
        // width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: Text('Buy')),
                    Expanded(child: Text('Sell')),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
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

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          return BlocProvider.of<RatesBloc>(context).add(FetchRatesEvent());
        },
        child: ListView(
            // physics: const BouncingScrollPhysics(
            // parent: AlwaysScrollableScrollPhysics()),
            physics: const ClampingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ]),
      ),
    );
  }
}

class ProgressGoWest extends StatelessWidget {
  const ProgressGoWest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // bool isDarkMode = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 150,
          height: 150,
          child: Stack(children: [
            // Image(
            //     image: isDarkMode
            //         ? AssetImage("assets/logo_tr.png")
            //         : AssetImage("assets/logo_inv_tr.png")),
            Center(
              child: Transform.scale(
                scale: 3,
                child: const CircularProgressIndicator(
                  strokeWidth: 4,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

// Future<void> _launchURL(String url, BuildContext context) async {
//   if (!await launchUrl(Uri.parse(url),
//       mode: LaunchMode.externalNonBrowserApplication)) {
//     if (!await launchUrl(Uri.parse(url),
//         mode: LaunchMode.externalApplication)) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return _buildPlatformAlertDialog(context);
//         },
//       );
//     }
//     ;
//   }
// }

// Widget _buildPlatformAlertDialog(BuildContext context) {
//   if (Theme.of(context).platform == TargetPlatform.iOS) {
//     return CupertinoAlertDialog(
//       title: Text(S.current.error),
//       content: Text(S.current.error_message),
//       actions: [
//         CupertinoDialogAction(
//           child: Text('Ок'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ],
//     );
//   } else {
//     return AlertDialog(
//       title: Text(S.current.error),
//       content: Text(S.current.error_message),
//       actions: [
//         TextButton(
//           child: Text('Ок'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ],
//     );
//   }
// }
