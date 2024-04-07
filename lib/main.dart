import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './screens/Home/index.dart';
import './screens/Splash/index.dart';
import 'screens/Login/SignIn/SignIn.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Telefonun saga sola donmesini engeller.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await dotenv.load(fileName: ".env");

  await Hive.initFlutter();
  await Hive.openBox('auth');
  await Hive.openBox('remember');

  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: FToastBuilder(),
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Giri',
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black87,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          primary: const Color(0xff23A0F3),
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/signIn': (context) => SignIn(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
