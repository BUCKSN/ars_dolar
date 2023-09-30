import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocks/rates/dolar_bloc.dart';

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
