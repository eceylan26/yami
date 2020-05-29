import 'dart:async';
import 'package:flutter/material.dart';

class QRDeneme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "QR Deneme",
      theme: new ThemeData(primaryColor: Colors.blue),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyPageState();
  }
}

class MyPageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffe8df),
      body: new SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Center(
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }


}
