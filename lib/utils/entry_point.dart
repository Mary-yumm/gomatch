import 'package:flutter/material.dart';
import 'package:gomatch/components/side_menu.dart';
import 'package:gomatch/screens/home_screen.dart';
import 'package:gomatch/models/menu_btn.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});
  static const String idScreen = "EntryPoint";

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  bool isSideMenuClosed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          // Main content (home screen)
          HomeScreen(),

          // Side menu overlay
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            width: 288,
            left: isSideMenuClosed ? -288 : 0,
            height: MediaQuery.of(context).size.height,
            child: SideMenu(isMenuOpen: !isSideMenuClosed), // Pass menu state
          ),

          // Menu button with animated x-position
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideMenuClosed ? 16 : 230, // X position changes when menu opens
            top: 37,
            child: IconButton(
              icon: Icon(
                isSideMenuClosed ? Icons.menu : Icons.arrow_back,  // Toggle between menu and arrow icons
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                setState(() {
                  isSideMenuClosed = !isSideMenuClosed;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
