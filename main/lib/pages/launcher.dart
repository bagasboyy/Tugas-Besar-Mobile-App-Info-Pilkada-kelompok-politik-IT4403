import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:main/pages/login.dart';

class LauncherPage extends StatefulWidget {
  const LauncherPage({super.key});

  @override
  _LauncherPageState createState() => new _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    super.initState();
    startLaunching();
  }
  startLaunching() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return LoginPage() ;
      }));
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xfff44336), 
    ));
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xfff44336), Color(0xfff53935)])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                "assets/splash_logo.png",
                height: 250.0,
                width: 250.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}