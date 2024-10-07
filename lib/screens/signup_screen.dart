import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomatch/main.dart';
import 'package:gomatch/screens/home_screen.dart';
import 'package:gomatch/screens/login_screen.dart';
import 'package:gomatch/utils/colors.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  static const String idScreen = "SignUp";
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 40.0),
              const Image(
                image: AssetImage("assets/images/logoTransparent.png"),
                width: 390.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white, //label color
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white, //hint color
                          fontSize: 10.0,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white, //Typed text color
                      ),
                    ),

                    const SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white, //label color
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white, //hint color
                          fontSize: 10.0,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white, //Typed text color
                      ),
                    ),

                    const SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "Phone",
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white, //label color
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white, //hint color
                          fontSize: 10.0,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white, //Typed text color
                      ),
                    ),

                    const SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white, //Label color
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white, //hint text color
                          fontSize: 10.0,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white, //Typed text color
                      ),
                    ),

                    const SizedBox(
                      height: 15.0,
                    ), // space between containers

                    // Updated to ElevatedButton
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                        foregroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      child: Container(
                        height: 50.0,
                        child: const Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                                fontSize: 18.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (nameTextEditingController.text.length < 3) {
                          displayToastMessage(
                              "Name must be atleast 3 characters.", context);
                        } else if (!emailTextEditingController.text
                            .contains("@")) {
                          displayToastMessage(
                              "Email address is not valid", context);
                        } else if (phoneTextEditingController.text.isEmpty) {
                          displayToastMessage(
                              "Phone Number is mandatory", context);
                        } else if (passwordTextEditingController.text.length <
                            6) {
                          displayToastMessage(
                              "Password must be atleast 6 characters.",
                              context);
                        } else {
                          registerNewUser(context);
                        }

                        //print("Login button clicked");
                      },
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const LoginScreen()), // Create a route to SignupScreen
                    (Route<dynamic> route) =>
                        false, // Remove all previous routes
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, // Set the text color to white
                ),
                child: const Text(
                  "Already have an Account? Login Here.",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> registerNewUser(BuildContext context) async {
    try {
      // Create a new user
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
      );

      User? firebaseUser =
          userCredential.user; // Get the user from UserCredential

      if (firebaseUser != null) {
        // User successfully registered
        // You can navigate to the next screen or show a success message here
        Map userDataMap = {
          "name": nameTextEditingController.text.trim(),
          "email": emailTextEditingController.text.trim(),
          "phone": phoneTextEditingController.text.trim(),
        };
        usersRef.child(firebaseUser.uid).set(userDataMap);
        displayToastMessage(
            "Congratulations, your account has been created", context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomeScreen()), // Create a route to HomeScreen
          (route) => false,
        );
      } else {
        // User registration failed
        // Show an error message here
        displayToastMessage("New user account has not been created.", context);
      }
    } catch (e) {
      // Handle errors (e.g., invalid email, weak password, etc.)
      //print("Error: $e");
      // Show an error message to the user
      displayToastMessage("Error: " + e.toString(), context);
    }
  }

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
