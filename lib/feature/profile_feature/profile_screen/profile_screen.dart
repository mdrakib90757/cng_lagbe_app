import 'package:cng_lagbe_app/core/utils/color.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: 120,
                width: double.infinity,
                color: AppColors.primaryDark,
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 70,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/image/user.png'),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 60),

          const Text(
            "জাহিদ হোসেন",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Text(
            "0180XXXXXXX",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),

          const SizedBox(height: 30),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(Icons.history, "রাইড হিস্ট্রি", Colors.teal),
                const Divider(height: 1),
                _buildMenuItem(Icons.home, "সেভ করা লোকেশন", Colors.lightGreen),
                const Divider(height: 1),
                _buildMenuItem(
                  Icons.notifications,
                  "নোটিফিকেশন",
                  Colors.redAccent,
                ),
                const Divider(height: 1),
                _buildMenuItem(Icons.settings, "সেটিংস", Colors.blueGrey),
                const Divider(height: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, Color iconBgColor) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconBgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {},
    );
  }
}
