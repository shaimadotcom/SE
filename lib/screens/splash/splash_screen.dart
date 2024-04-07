import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:learnjava/localization/language_constrants.dart';
import 'package:learnjava/providers/splash_provider.dart';
import 'package:learnjava/screens/auth/main_Auth_screen.dart';
import 'package:learnjava/screens/base_widgets/no_internet_screen.dart';
import 'package:learnjava/utill/color_resources.dart';
import 'package:learnjava/utill/images.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();
    bool firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(!firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        isNotConnected ? const SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? getTranslated('no_connection', context)??"No Connection" : getTranslated('connected', context)??"Connected",
            textAlign: TextAlign.center,
          ),
        ));
        if(!isNotConnected) {
          _route();
        }
      }
      firstTime = false;
    });

    _route();
  }

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged.cancel();
  }

  void _route() {
         Timer(const Duration(seconds: 1), () async {

                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const AuthScreen()));

        });

   // });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _globalKey,
      body: Provider.of<SplashProvider>(context).hasConnection ? Stack(
        clipBehavior: Clip.none, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color:  ColorResources.primaryColor,
            child: Image.asset(Images.splashLogo,  fit: BoxFit.cover)
          )
        ],
      ) : const NoInternetOrDataScreen(isNoInternet: true, child: SplashScreen()),
    );
  }

}
