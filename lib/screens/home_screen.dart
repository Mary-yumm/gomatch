import 'package:flutter/material.dart';
import 'package:gomatch/components/side_drawer/side_menu.dart';
import 'package:gomatch/models/menu_btn.dart';
import 'package:gomatch/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  static const String idScreen = "HomeScreen";

  HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSideMenuClosed = true;
  int? selectedCarIndex; // Track which car is selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/map.png',
              fit: BoxFit.cover,
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            width: 288,
            left: isSideMenuClosed ? -288 : 0,
            height: MediaQuery.of(context).size.height,
            child: SideMenu(isMenuOpen: !isSideMenuClosed),
          ),

          Positioned(
            top: 10,
            left: isSideMenuClosed ? 16 : 225,
            child: MenuBtn(
              press: () {
                setState(() {
                  isSideMenuClosed = !isSideMenuClosed;
                });
              },
              isMenuOpen: !isSideMenuClosed,
            ),
          ),

          // Floating action button for bottom sheet
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () => _showCarpoolBottomSheet(context),
              backgroundColor: AppColors.primaryColor,
              child: const Icon(Icons.directions_car, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Function to show the bottom sheet
  void _showCarpoolBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.of(context)
                    .pop(); // Close bottom sheet when tapping outside
              },
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {}, // Prevent dismissing when tapping inside
                    child: DraggableScrollableSheet(
                      expand: true,
                      initialChildSize: 0.5,
                      minChildSize: 0.5,
                      maxChildSize: 1,
                      builder: (context, scrollController) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      width: 50,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  const Text(
                                    "Available Cars",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 20),

                                  // Dropdowns for City and Destination
                                  const Text(
                                    "Pickup Location",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  DropdownButton<String>(
                                    isExpanded: true,
                                    items: <String>['Location A', 'Location B']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (_) {},
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Select Destination",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  DropdownButton<String>(
                                    isExpanded: true,
                                    items: <String>[
                                      'Destination A',
                                      'Destination B'
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (_) {},
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Available Cars",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),

                                  // List of cars available with onTap for details
                                  _buildCarCard(
                                    context,
                                    setModalState:
                                        setModalState, // Pass setModalState to manage state inside the modal
                                    index: 0,
                                    carDetails: "10-Seater, Male & Female",
                                    pickupTime: "9:30 AM",
                                    departureTime: "10:00 AM",
                                    driverPhone: "+123456789",
                                    isKycVerified: true,
                                    malePassengers: 5,
                                    femalePassengers: 5,
                                  ),
                                  _buildCarCard(
                                    context,
                                    setModalState:
                                        setModalState, // Pass setModalState to manage state inside the modal
                                    index: 1,
                                    carDetails: "10-Seater, Female Only",
                                    pickupTime: "11:00 AM",
                                    departureTime: "11:30 AM",
                                    driverPhone: "+987654321",
                                    isKycVerified: true,
                                    malePassengers: 0,
                                    femalePassengers: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Car Card Widget
  Widget _buildCarCard(BuildContext context,
      {required int index,
      required String carDetails,
      required String pickupTime,
      required String departureTime,
      required String driverPhone,
      required bool isKycVerified,
      required int malePassengers,
      required int femalePassengers,
      required StateSetter setModalState}) {
    // Add setModalState here
    return GestureDetector(
      onTap: () {
        setModalState(() {
          // Toggle the selected car
          selectedCarIndex = selectedCarIndex == index ? null : index;
        });
      },
      child: Card(
        color: AppColors.primaryColor, // Set card color to primary color
        margin: const EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.directions_car,
                      size: 40,
                      color:
                          AppColors.secondaryColor), // Secondary color for icon
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(carDetails,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white)), // White text
                      const SizedBox(height: 5),
                      Text("Pickup: $pickupTime",
                          style: const TextStyle(color: Colors.white)),
                      Text("Departs: $departureTime",
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Show extra details if this car is selected
              if (selectedCarIndex == index) ...[
                const Divider(color: Colors.white), // Divider with white color
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Driver phone number and icon
                    Row(
                      children: [
                        const Icon(Icons.phone, color: Colors.green),
                        const SizedBox(width: 5),
                        Text(driverPhone,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                      ],
                    ),
                    // KYC verification badge
                    Row(
                      children: [
                        const Icon(Icons.verified,
                            color: Colors.green, size: 20),
                        const SizedBox(width: 5),
                        Text(
                          isKycVerified ? "Verified" : "Unverified",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: isKycVerified
                                  ? Colors.green
                                  : Colors.redAccent),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Show male and female passenger details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Male: $malePassengers",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Female: $femalePassengers",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Book Ride button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement your book ride logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColors.secondaryColor, // Button in secondary color
                    ),
                    child: const Text(
                      "Book Ride",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
