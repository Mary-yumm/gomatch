import 'package:flutter/material.dart';
import 'package:gomatch/utils/colors.dart';

class LogoutConfirmationBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      backgroundColor: AppColors.primaryColor,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Logout Confirmation', style: TextStyle(fontSize: 18, color: Colors.white)),
              const SizedBox(height: 20),
              const Text('Are you sure you want to logout?', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    child: const Text('Cancel', style: TextStyle(color: AppColors.secondaryColor)),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle logout
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    child: const Text('Logout', style: TextStyle(color: AppColors.secondaryColor)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
