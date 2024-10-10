import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:flutter/material.dart';
import 'package:gomatch/screens/driver_mode_screen.dart';
import 'package:gomatch/screens/faq_screen.dart';
import 'package:gomatch/screens/history_screen.dart';
import 'package:gomatch/screens/home_screen.dart';
import 'package:gomatch/screens/login_screen.dart';
import 'package:gomatch/components/side_menu.dart';
import 'package:gomatch/screens/settings_screen.dart';
import 'package:gomatch/screens/signup_screen.dart';
import 'package:gomatch/utils/entry_point.dart';
import 'package:gomatch/utils/firebase_ref.dart'; // Import usersRef from firebase_ref.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Go-Match',
      theme: ThemeData(
        fontFamily: "Brand Bold",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: EntryPoint.idScreen,
      routes: {
        EntryPoint.idScreen: (context) => const EntryPoint(),
        SignupScreen.idScreen: (context) => SignupScreen(),
        LoginScreen.idScreen: (context) => LoginScreen(),
        HomeScreen.idScreen: (context) => const HomeScreen(),
        DriverModeScreen.idScreen: (context)=>const DriverModeScreen(),
        FAQScreen.idScreen:(context)=>const FAQScreen(),
        HistoryScreen.idScreen:(context)=>const HistoryScreen(),
        SettingsScreen.idScreen:(context)=>const SettingsScreen(),

      },
    );
  }
}
