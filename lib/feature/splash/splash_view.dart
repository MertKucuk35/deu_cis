import 'package:deu_cis/feature/home/home_view.dart';
import 'package:deu_cis/product/vm/auth_view_model.dart';
import 'package:deu_cis/feature/login/login_view.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/enums/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setup();
  }

  Future<void> _setup() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Future.microtask(
      () async {
        await locator<AuthViewModel>().checkUserAuth(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ResponsiveBreakpoints.of(context).isMobile
                ? SizedBox(
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Image.asset(ImageConstants.appLogo.toPng))
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.height * 0.5,
                    child: Image.asset(ImageConstants.appLogo.toPng)),
            const SizedBox(height: 25),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
