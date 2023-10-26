import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:ps/portfolio.dart';
import 'package:ps/res/res.dart';
import 'package:ps/util/routes.dart';
import 'home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  setUrlStrategy(PathUrlStrategy());
  runApp(PersonalSite());
}

class PersonalSite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        //colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
      ),
      initialRoute: Routes.portfolio,
      routes: {
        Routes.home: (context) => Home(),
        Routes.portfolio: (context) => Portfolio(),
      },
    );
  }
}
