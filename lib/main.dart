import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/auth/login_screen/login_screen.dart';
import 'package:todo_app/home/auth/register_screen/register_screen.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/theme/my_theme.dart';

import 'home/home_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // FirebaseFirestore.instance.clearPersistence();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
  runApp(ChangeNotifierProvider(
      create: (context) => AppConfigProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
      },
      themeMode: provider.appTheme,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkMode,
      locale: Locale(provider.appLanguage),
    );
  }
}
