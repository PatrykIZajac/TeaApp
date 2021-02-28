import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/database/cartDB.dart';
import 'package:tea_app/database/favDB.dart';
import 'package:tea_app/local_storage/user_preferences.dart';
import 'package:tea_app/providers/cart_provider.dart';
import 'package:tea_app/providers/favorite_provider.dart';
import 'package:tea_app/providers/tea_provider.dart';
import 'package:tea_app/screens/main/home_screen.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Db().init();
  await UserPreferences().init();
  await DbFav().init();
  runApp(MultiProvider(
    providers: [
      ListenableProvider<TeaProvider>(create: (_) => TeaProvider()),
      ListenableProvider<CartProvider>(create: (_) => CartProvider()),
      ListenableProvider<FavoriteProvider>(create: (_) => FavoriteProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Color(0xFF11bb6c),
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Tea shop app',
      theme: _lightTheme,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale(UserPreferences().getLang()),
      home: HomeScreen(),
    );
  }
}
