import 'dart:io';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:learnjava/providers/auth_provider.dart';
import 'package:learnjava/providers/home_provider.dart';
import 'package:learnjava/providers/localization_provider.dart';
import 'package:learnjava/providers/profile_provider.dart';
import 'package:learnjava/providers/sound_provider.dart';
import 'package:learnjava/providers/splash_provider.dart';
import 'package:learnjava/screens/splash/splash_screen.dart';
import 'package:learnjava/utill/app_constants.dart';
import 'package:provider/provider.dart';
import 'helper/custom_delegate.dart';
import 'localization/app_localization.dart';
import 'di_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<HomeProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<SoundProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final soundProvider = Provider.of<SoundProvider>(context, listen: false);
    if(soundProvider.isSoundPlaying){
      soundProvider.initializeSound();
    }
  }
  @override
  Widget build(BuildContext context) {
    final soundProvider = Provider.of<SoundProvider>(context,listen: false);
    List<Locale> locals = [];
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    for (var language in AppConstants.languages) {
      locals.add(Locale(language.languageCode!, language.countryCode));
    }
    soundProvider.toggleSound;
    return MaterialApp(title: AppConstants.appName, navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        locale: Provider.of<LocalizationProvider>(context).locale,
        localizationsDelegates: [AppLocalization.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate, FallbackLocalizationDelegate()],
        supportedLocales: locals, home: const SplashScreen()

    );
  }
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
class Get {
  static BuildContext? get context => navigatorKey.currentContext;
  static NavigatorState? get navigator => navigatorKey.currentState;
}