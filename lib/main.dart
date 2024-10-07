import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gomatch/screens/home_screen.dart';
import 'package:gomatch/screens/login_screen.dart';
import 'package:gomatch/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");

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
      initialRoute: LoginScreen.idScreen,
      routes: {
        SignupScreen.idScreen:(context) => SignupScreen(),
        LoginScreen.idScreen:(context)=> LoginScreen(),
        HomeScreen.idScreen:(context)=>HomeScreen()
      },
    );
  }
}
