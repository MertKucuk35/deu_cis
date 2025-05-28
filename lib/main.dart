import 'package:deu_cis/feature/demo/excell_file_import.dart';
import 'package:deu_cis/feature/home/home_view.dart';
import 'package:deu_cis/feature/login/login_view.dart';
import 'package:deu_cis/feature/public_profile/speakers_detail.dart';
import 'package:deu_cis/feature/home/subview/qr_scan/qr_view.dart';
import 'package:deu_cis/feature/home/subview/qr_scan/widget/qr_scanner_widget.dart';
import 'package:deu_cis/feature/splash/splash_view.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, child) => ResponsiveBreakpoints.builder(
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
              child: child!,
            ),
        debugShowCheckedModeBanner: false,
        title: StringConsts.appName,
        theme: AppTheme.lightTheme,
        // darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: ExcellFileImport()
        //SplashView()
        // QRScannerWidget(
        //   onQRCodeScanned: (String) {},
        // ) //HomeScreen()
        //SplashView()
        //SpeakersDetailView(),
        //const HomewView(),
        );
  }
}
