import 'dart:convert';

import 'package:driver_assistant_app_2025/AllScreens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;

import 'TextToSpeech.dart';
import 'drawer.dart';
import 'login.dart';

class blindSpot extends StatefulWidget {

  @override
  _blindSpot createState() => _blindSpot();
}

class _blindSpot extends State<blindSpot> {
  bool start = false;
  String localIp = "http://192.168.83.122:5555/", img_url = "", res_text = "";
  TextToSpeechConverter TextSpeech = TextToSpeechConverter();
  late stt.SpeechToText _speech;
  bool _isSound = false;

  @override
  void initState() {
    super.initState();
    app_start();
  }

  void app_start() async {
    while (true) {
      try {
        var url = localIp + 'blind_spot';
        var response = await http.get(Uri.parse(url));

        var decoded = json.decode(response.body) as Map<String, dynamic>;
        print(decoded['res']);
        print(decoded['accuracy']);

        setState(() =>{img_url = localIp + "images/" + decoded['image'].toString(),res_text=decoded['res'].toString()});
        await TextSpeech.speak(decoded['res'].toString());

        await Future.delayed(Duration(seconds: 5));
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parking Slots"),
      ),
      backgroundColor: Colors.white,
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 50),
              Center(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      img_url, // Replace with your image URL
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error, size: 50, color: Colors.red);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.speaker, color: Colors.blue, size: 50),
                  SizedBox(width: 10),
                  Text(
                    res_text,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
