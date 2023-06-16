import 'package:flutter/material.dart';
import 'package:main/pages/home.dart';
import 'package:main/pages/info_calon.dart';
import 'package:main/pages/launcher.dart';
import 'package:main/pages/profil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';



Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(     
      debugShowCheckedModeBanner: false,
      home: LauncherPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String searchValue = '';
  int _index = 0;
  final screens = [
    HomePage(),
    InfoCalonPage(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: Scaffold (
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        backgroundColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_search_rounded),
            label: 'Info Calon',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
            backgroundColor: Colors.white,
          ),
        ],
      ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

}