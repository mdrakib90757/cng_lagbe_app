import 'package:cng_lagbe_app/core/utils/color.dart';
import 'package:cng_lagbe_app/feature/profile_feature/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../ride_details_fature/ride_details_screen/ride_details_screen.dart';

class MainMapScreen extends StatefulWidget {
  const MainMapScreen({super.key});

  @override
  State<MainMapScreen> createState() => _MainMapScreenState();
}

class _MainMapScreenState extends State<MainMapScreen> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(23.8103, 90.4125);

  int currentScreenIndex = 0;

  @override
  void initState() {
    super.initState();
    _requestPermission();

  }

  Future<void> _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      debugPrint("Location Permission Granted");
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        centerTitle: true,
        title: currentScreenIndex == 0
            ? Image.asset(
                "assets/image/cng_lagbe.png",
                height: 40,
                width: 150,
                fit: BoxFit.contain,
              )
            : Text(
                currentScreenIndex == 1 ? "যাত্রা চলছে..." : "ভাড়া জমুন...",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
        // title: Text(
        //   currentScreenIndex == 0 ? "CNG লাগবে?" : (currentScreenIndex == 1 ? "যাত্রী চলছে..." : "ভাড়া জমুন..."),
        //   style: const TextStyle(color: Colors.white, fontSize: 18),
        // ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => mapController = controller,
            initialCameraPosition: CameraPosition(target: _center, zoom: 15.0),
            zoomControlsEnabled: true,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            fortyFiveDegreeImageryEnabled: true,
          ),

          if (currentScreenIndex == 0) _buildRideDetailsUI(),
          if (currentScreenIndex == 1) _buildOnTripUI(),
          if (currentScreenIndex == 2) _buildTripSummaryUI(),
        ],
      ),
    );
  }

  Widget _buildRideDetailsUI() {
    return Positioned(
      bottom: 20,
      left: 15,
      right: 15,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _locationTile(
                  Icons.my_location,
                  Colors.green,
                  "Pick a Location",
                ),
                const Divider(height: 1),
                _locationTile(Icons.location_on, Colors.red, "Set Destination"),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _customButton("Find CNG", AppColors.primaryDark, () {
            setState(() => currentScreenIndex = 1);
          }),
        ],
      ),
    );
  }

  Widget _buildOnTripUI() {
    return Positioned(
      bottom: 20,
      left: 15,
      right: 15,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RideDetailsScreen()),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.person, color: Colors.orange),
                        Text(
                          " যাত্রী ১ জন",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      "৳ ১৫০",
                      style: TextStyle(
                        color: AppColors.primaryDark,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                _customButton("রাইড শুরু করুন", const Color(0xFFE65100), () {
                  setState(() => currentScreenIndex = 2);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTripSummaryUI() {
    return Positioned(
      bottom: 20,
      left: 15,
      right: 15,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Icon(Icons.account_balance_wallet, color: Colors.green),
                  SizedBox(width: 10),
                  Text(
                    "ভাড়া পরিশোধ করুন",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              _customButton("রাইড শেষ করুন", AppColors.primaryDark, () {
                setState(() => currentScreenIndex = 0);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _locationTile(IconData icon, Color color, String text) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: Colors.grey)),
      trailing: const Icon(Icons.chevron_right),
      dense: true,
    );
  }

  Widget _customButton(String label, Color color, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
