import 'package:flutter/material.dart';

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
