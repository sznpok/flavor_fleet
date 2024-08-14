import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../features/splash/presentation/view/splash_view.dart';
import 'themes/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: 'test_public_key_d5d9f63743584dc38753056b0cc737d5',
      builder: (context, navkey) {
        return MaterialApp(
          navigatorKey: navkey,
          localizationsDelegates: const [
            KhaltiLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          title: 'Flavour Fleet',
          theme: AppTheme.getApplicationTheme(false),
          home: const SplashView(),
        );
      },
    );
  }
}
