import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/HomePage.dart';
import 'pages/LoaderPage.dart';
import 'pages/LoginPage.dart';
import 'pages/ProfilePage.dart';
import 'pages/QrCodePage.dart';
import 'providers/UserProvider.dart';

void main() => runApp(PresenceApp());

class PresenceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserProvider())
      ],
          child: MaterialApp(
       title: 'Connectivity PresenceApp UI',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: Colors.white
              ),
      initialRoute: SpashScreen.routeName,
       routes: {
             SpashScreen.routeName: (context) => SpashScreen(),
             HomePage.routeName: (context) => HomePage(),
             LoginPage.routeName: (context) => LoginPage(),
             LoaderPage.routeName: (context) => LoaderPage(),
             ProfilePage.routeName: (context) => ProfilePage(),
             QrCodePage.routeName: (context) => QrCodePage()
       },
       debugShowCheckedModeBanner: false
        ),
    );
  }
}

class SpashScreen extends StatelessWidget {

  static const routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen.callback(
          name: 'images/splash_screen_presence.flr',
        startAnimation: 'splash',
        onSuccess: (res) {
            print(res);
            if(res == true ) {
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            } else {
              Navigator.pushReplacementNamed(context, LoginPage.routeName);
            }
        },
        onError: (res1, res2) {
          Navigator.pushReplacementNamed(context, LoginPage.routeName);
        },
        until: () => Provider.of<UserProvider>(context).tryAutoLogin(),
      ),
    );
  }
}
