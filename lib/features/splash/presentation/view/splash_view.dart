import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../screen/home_screen.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/custom_storage.dart';
import '../../../auth/presentation/view/login_view.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  navigateScreen() async {
    String? accessToken = await readTokenAccess();
    if (accessToken != null && accessToken.isNotEmpty) {
      ApiToken.token = accessToken.toString();
    }
    if (accessToken != null) {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false,
          );
        },
      );
    } else {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginView()),
            (route) => false,
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    navigateScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/images/logo.png'),
                ),
                const Text(
                  'FlaviourFleet',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 10),
                const CircularProgressIndicator(),
                const SizedBox(height: 10),
                const Text('version : 1.0.0')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
