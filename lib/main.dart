import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:ps/res/res.dart';

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
    return Builder(
          builder: (context){
            return MaterialApp(
              title: Strings.title,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity,
                brightness: Brightness.light,
                primaryColor: Colors.white,
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Colors.white,
                  selectionColor: ThemeColors.selectionColor,
                  selectionHandleColor: Colors.transparent,
                ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
              ),
              initialRoute: '/',
              routes: {
                '/': (context) => Adapter(),
                //'/home': (context) => HomeAdapter(),
                //'/account': (context) => EditAccountAdapter(),
              },
            );
          }
    );
  }
}

class Adapter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth > 900 && kIsWeb){
          return Home();
        }
        else if (constraints.maxWidth > 600) {
          return Home();
        } else {
          return Home();
        }
      },
    );
  }
}