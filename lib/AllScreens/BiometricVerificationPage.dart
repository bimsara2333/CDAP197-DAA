import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
class BiometricVerificationPage extends StatefulWidget {
  @override
  _BiometricVerificationPage createState() => _BiometricVerificationPage();
}

class _BiometricVerificationPage extends State<BiometricVerificationPage> {

  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticated = false;

  Future<void> authenticateWithFaceID() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      if (!isAvailable) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Biometric authentication is not available')),
        );
        return;
      }

      final isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to access the app',
        options: const AuthenticationOptions(
          biometricOnly: true,
        )
      );

      setState(() {
        _isAuthenticated = isAuthenticated;
      });

      if (isAuthenticated) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Face Unlock Successful!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Authentication failed!')),
        );
      }
    } catch (e) {
      print('Error during authentication: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Driver Identification',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Biometric Verification',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              "Without your verification,\nWe couldn't allow you to access this vehicle",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Icon(
              Icons.face,
              size: 100,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Owns a vehicle ? Click Here to continue",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            Center(
              child: _isAuthenticated
                  ? Text('Welcome! You are authenticated.')
                  : ElevatedButton(
                onPressed:(){ authenticateWithFaceID();},
                child: Text('Unlock with Face ID'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
