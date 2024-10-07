import 'package:flutter/material.dart';
import 'package:gomatch/utils/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 65.0),
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
                    const TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
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
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white, //Typed text color
                      ),
                    ),

                    const SizedBox(
                      height: 1.0,
                    ),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
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
                      style: TextStyle(
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
                            "Login",
                            style: TextStyle(
                                fontSize: 18.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      onPressed: () {
                        //print("Login button clicked");
                      },
                    ),
                  ],
                ),
              ),

              
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, // Set the text color to white
                ),
                child: const Text(
                  "Do not have an Account? Register Here.",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
