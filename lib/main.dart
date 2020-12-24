import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/local_storage/user_preferences.dart';
import 'package:tea_app/providers/tea_provider.dart';
import 'package:tea_app/screens/main/home_screen.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().init();
  runApp(MultiProvider(
    providers: [
      ListenableProvider<TeaProvider>(create: (_) => TeaProvider()),
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
    return MaterialApp(
      title: 'Flutter Demo',
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
