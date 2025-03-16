import 'package:driver_assistant_app_2025/AllScreens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
//up to testing
class WelcomeScreen extends StatefulWidget {
  static const String idScreen = "welcomeScreen";

  @override
  _WelcomeScreen createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    navigateScreen(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 35.0,
              ),
              Image(
                image: AssetImage("assets/images/logo.png"),
                width: 250.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Welcome",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Driver Assistant Application",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              SizedBox(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue), // Change color here
                ),
                height: 50.0,
                width: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateScreen(context) async{
    var d = Duration(seconds: 3);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Future.delayed(d, () {
      if(prefs.getString('email')!=null){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => dashboard()));
      }else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => login()));
      }
    });
  }
}
