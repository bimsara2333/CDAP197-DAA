import 'package:driver_assistant_app_2025/AllScreens/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addUser.dart';
import 'dashboard.dart';

class AppDrawer extends StatefulWidget {
//pol
  @override
  _AppDrawer createState() => _AppDrawer();
}

class _AppDrawer extends State<AppDrawer> {
  String name = "",email="";

  @override
  void initState() {
    super.initState();
    initialise();
  }

  initialise() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name')!;
      email = prefs.getString('email')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue, // Background color for the icon
                  child: Icon(
                    Icons.account_circle, // Icon representing a user
                    size: 40, // Icon size
                    color: Colors.white, // Icon color
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Hello, "+name,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  email,
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          // Navigation Items
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text("Dashboard"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => dashboard()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => settings()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              Navigator.pop(context); // Add logout logic if necessary
            },
          ),
        ],
      ),
    );
  }
}
