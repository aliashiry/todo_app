import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/providers/app_config_provider.dart';
import 'package:todo_app/core/providers/auth_provider.dart';
import 'package:todo_app/core/theme/my_theme.dart';
import 'package:todo_app/pages/auth/login_screen/login_screen.dart';
import 'package:todo_app/pages/auth/register_screen/register_screen.dart';
import 'package:todo_app/pages/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  // FirebaseFirestore.instance.settings =
  //     const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => AppConfigProvider()
            ..getTheme()
            ..getLanguage()),
      ChangeNotifierProvider(create: (context) => AuthProviders()),
    ],
    child: MyApp(),
  ));
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
        HomeScreen.routeName: (context) => HomeScreen(),
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
