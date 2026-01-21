import 'package:cng_lagbe_app/feature/auth/auth_screen/login_screen.dart';
import 'package:flutter/material.dart';

class CngIntroScreen extends StatefulWidget {
  const CngIntroScreen({super.key});

  @override
  State<CngIntroScreen> createState() => _CngIntroScreenState();
}

class _CngIntroScreenState extends State<CngIntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset('assets/image/wel.png', fit: BoxFit.cover),
          ),

          // Get Started Button
          Positioned(
            left: 24,
            right: 24,
            bottom: 40,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1C6A47),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
