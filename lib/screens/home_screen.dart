import 'package:flutter/material.dart';
import 'package:gomatch/components/side_drawer/side_menu.dart';
import 'package:gomatch/models/menu_btn.dart';  // Import MenuBtn
import 'package:gomatch/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  static const String idScreen = "HomeScreen";

  HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSideMenuClosed = true; // Track side menu state for animation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          // Main content (home screen)
          Positioned.fill(
            child: Image.asset(
              'assets/images/map.png',
              fit: BoxFit.cover,
            ),
          ),

          // Side menu overlay
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            width: 288,
            left: isSideMenuClosed ? -288 : 0,
            height: MediaQuery.of(context).size.height,
            child: SideMenu(isMenuOpen: !isSideMenuClosed), // Pass menu state
          ),

          // Use MenuBtn instead of IconButton and pass menu state to change icon
          Positioned(
            top: 10,
            left: isSideMenuClosed ? 16 : 225, // X position changes when menu opens
            child: MenuBtn(
              press: () {
                setState(() {
                  isSideMenuClosed = !isSideMenuClosed; // Toggle menu state
                });
              },
              isMenuOpen: !isSideMenuClosed,  // Pass menu state to change icon
            ),
          ),
        ],
      ),
    );
  }
}
