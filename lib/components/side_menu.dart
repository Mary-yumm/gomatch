import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gomatch/models/rive_asset.dart';
import 'package:gomatch/components/info_card.dart';
import 'package:gomatch/components/side_menu_tile.dart';
import 'package:gomatch/screens/driver_mode_screen.dart';
import 'package:gomatch/screens/faq_screen.dart';
import 'package:gomatch/screens/history_screen.dart';
import 'package:gomatch/screens/home_screen.dart';
import 'package:gomatch/screens/profile_screen.dart';
import 'package:gomatch/screens/settings_screen.dart';
import 'package:gomatch/utils/colors.dart';
import 'package:gomatch/utils/rive_utils.dart';
import 'package:rive/rive.dart';

class SideMenu extends StatefulWidget {
  final bool isMenuOpen; // New parameter to track if the menu is open

  const SideMenu({super.key, required this.isMenuOpen}); // Add required parameter

  static const String idScreen = "SideMenu";

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedMenu = sideMenus.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: AppColors.primaryColor,
        child: SafeArea(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProfileScreen.idScreen);
                },
                child: const InfoCard(name: "Name"),
              ),
              // Display side menu items
              ...sideMenus.map(
                (menu) => SideMenuTile(
                  menu: menu,
                  riveonInit: (artboard) {
                    // Initialize Rive animations
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard,
                            stateMachineName: menu.stateMachineName);
                    menu.input = controller.findSMI("active") as SMIBool?;
                  },
                  press: () {
                    // Trigger the animation and change active menu
                    if (menu.input != null) {
                      menu.input!.change(true);
                    }

                    setState(() {
                      selectedMenu = menu;
                      print("Selected Menu: ${selectedMenu.title}"); // Debug line
                    });

                    // Reset other menus' animation
                    for (var otherMenu in sideMenus) {
                      if (otherMenu != menu && otherMenu.input != null) {
                        otherMenu.input!.change(false);
                      }
                    }
                    // Navigate to a relevant screen based on the menu title
                    Future.delayed(const Duration(milliseconds: 300), () {
                      switch (menu.title) {
                        case "Home":
                          Navigator.pushNamed(context, HomeScreen.idScreen);
                          break;
                        case "Request History":
                          Navigator.pushNamed(context, HistoryScreen.idScreen);
                          break;
                        case "Driver Mode":
                          Navigator.pushNamed(
                              context, DriverModeScreen.idScreen);
                          break;
                        case "Settings":
                          Navigator.pushNamed(context, SettingsScreen.idScreen);
                          break;
                        case "FAQ":
                          Navigator.pushNamed(context, FAQScreen.idScreen);
                          break;
                        default:
                          break;
                      }
                    });
                  },
                  isActive: selectedMenu == menu,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

