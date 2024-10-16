import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gomatch/components/side_drawer/side_menu.dart';
import 'package:gomatch/models/menu_btn.dart';
import 'package:gomatch/utils/colors.dart';
import 'package:gomatch/components/home_screen/car_card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  final Completer<GoogleMapController> _controllerGoogleMap =
      Completer<GoogleMapController>();
  late GoogleMapController newGoogleMapController;

  //For getting user's current location
  late Position currentPosition;

  // Check and request location permissions
  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return; // Exit or show an error message
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied');
      return; // Exit or show an error message
    }

    locatePosition(); // Call your location function if permissions are granted
  }

  void locatePosition() async {
    await _checkLocationPermission(); // Ensure permissions are checked first

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentPosition = position;
        LatLng latLatPosition = LatLng(position.latitude, position.longitude);
        CameraPosition cameraPosition =
            CameraPosition(target: latLatPosition, zoom: 14);
        newGoogleMapController
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      });
    } catch (e) {
      print(e); // Handle error, e.g., permission denied
    }
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  // Variables to track button position
  double buttonX = 295; // Initial horizontal position
  double buttonY = 600; // Initial vertical position

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            //for user's current loc
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,

            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              //for user's current loc
              locatePosition();
            },
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

          // Draggable Floating Action Button
          Positioned(
            left: buttonX,
            top: buttonY,
            child: Draggable(
              feedback: Material(
                child: FloatingActionButton(
                  onPressed: () => _showCarpoolBottomSheet(context),
                  backgroundColor: AppColors.primaryColor,
                  child: const Icon(Icons.directions_car,
                      color: AppColors.secondaryColor),
                ),
              ),
              childWhenDragging: Container(), // Show nothing while dragging
              child: FloatingActionButton(
                onPressed: () => _showCarpoolBottomSheet(context),
                backgroundColor: AppColors.primaryColor,
                child: const Icon(Icons.directions_car,
                    color: AppColors.secondaryColor),
              ),
              onDragEnd: (details) {
                // Update the position of the button when drag ends
                setState(() {
                  buttonX =
                      details.offset.dx - 28; // Adjust to center the button
                  buttonY =
                      details.offset.dy - 28; // Adjust to center the button
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  // Function to show the bottom sheet of Car Button
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
                            color: AppColors.lightPrimary,
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
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor),
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
                                    dropdownColor: AppColors.lightPrimary,
                                    items: <String>['Location A', 'Location B']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (_) {},
                                  ),
                                  const Divider(color: AppColors.primaryColor),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Select Destination",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  DropdownButton<String>(
                                    isExpanded: true,
                                    dropdownColor: AppColors.lightPrimary,
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
                                  const Divider(color: AppColors.primaryColor),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Available Cars",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),

                                  // Using CarCard widget for each car
                                  CarCard(
                                    index: 0,
                                    carDetails: "10-Seater, Male & Female",
                                    pickupTime: "9:30 AM",
                                    departureTime: "10:00 AM",
                                    driverPhone: "+123456789",
                                    isKycVerified: true,
                                    malePassengers: 5,
                                    femalePassengers: 3,
                                    selectedCarIndex: selectedCarIndex,
                                    available: 2,
                                    onCardTap: (int index) {
                                      setModalState(() {
                                        selectedCarIndex =
                                            selectedCarIndex == index
                                                ? null
                                                : index;
                                      });
                                    },
                                  ),
                                  CarCard(
                                    index: 1,
                                    carDetails: "10-Seater, Female Only",
                                    pickupTime: "11:00 AM",
                                    departureTime: "11:30 AM",
                                    driverPhone: "+987654321",
                                    isKycVerified: true,
                                    malePassengers: 0,
                                    femalePassengers: 7,
                                    available: 3,
                                    selectedCarIndex: selectedCarIndex,
                                    onCardTap: (int index) {
                                      setModalState(() {
                                        selectedCarIndex =
                                            selectedCarIndex == index
                                                ? null
                                                : index;
                                      });
                                    },
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
}
