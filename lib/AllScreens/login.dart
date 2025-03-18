import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_assistant_app_2025/AllScreens/dashboard.dart';
import 'package:driver_assistant_app_2025/AllScreens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatelessWidget {
  static const String idScreen = "login";

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  Image(
                    image: AssetImage("assets/images/logo.png"),
                    width: 250.0,
                    height: 250.0,
                    alignment: Alignment.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "ROADBUDDY",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Welcome Back!",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Let's help you meet up your tasks",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  TextField(
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Password Input
                  TextField(
                    controller: passwordTextEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Sign In Button
                  ElevatedButton(
                    onPressed: () {
                      if (!emailTextEditingController.text.contains("@")) {
                        displayToastMessage(
                            "Email address is not valid", context);
                      } else if (passwordTextEditingController.text.isEmpty) {
                        displayToastMessage("Password is mandatory.", context);
                      } else {
                        loginAndAuthenticateUser(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                    ),
                    child: Text(
                      "Sign In",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => register()));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return login();
        });
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final User? firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) //user created
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userid', firebaseUser.uid);
      print(firebaseUser.uid);

      try {
        Stream<DocumentSnapshot> stream =
            firestore.collection("users").doc(firebaseUser.uid).snapshots();

        stream.listen((snapshot) async{
          await prefs.setString('email', snapshot["email"].toString());
          await prefs.setString('name', snapshot["name"].toString());
          await prefs.setString('userType', "user");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => dashboard()));
          displayToastMessage("Welcome", context);
        });
      } catch (e) {
        print(e);
      }
    } else {
      displayToastMessage("Error Occured, can not.", context);
    }
  }
}
