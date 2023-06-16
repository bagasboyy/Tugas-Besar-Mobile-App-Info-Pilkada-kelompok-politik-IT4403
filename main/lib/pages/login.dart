import 'package:flutter/material.dart';
import 'package:main/main.dart';
import 'package:main/pages/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "komponen.dart" as dataglobal;
void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0.0,
        // ),
        body: const MyStatefulWidget(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 50)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Image.asset(
                    "assets/logo_kpu.png",
                    height: 200.0,
                    width: 200.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 75,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Username',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: "Password",
                ),
                controller: _passwordController,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () {
                      String username = _usernameController.text;
                      String password = _passwordController.text;
                      if (username.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Username dan Password harus diisi"),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      } else {
                        bool usernamenotfound = true;
                        bool passwordnotfound = true;

                        FirebaseFirestore.instance
                            .collection('users')
                            .where('username', isEqualTo: username)
                            .limit(1)
                            .get()
                            .then((QuerySnapshot querySnapshot) {
                          querySnapshot.docs.forEach((doc) {
                            if (doc.get('username') ==
                                _usernameController.text) {
                              usernamenotfound = false;
                              if (doc.get('password') ==
                                  _passwordController.text) {
                                    dataglobal.username = _usernameController.text;
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return LandingPage();
                                }));
                                passwordnotfound = false;
                              }
                            } else {
                              print("data ditolak");
                            }
                          });

                          if (usernamenotfound == true ||
                              passwordnotfound == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Username atau Password salah"),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }

                          _usernameController.text = '';
                          _passwordController.text = '';
                        });
                      }
                    })),
            Row(
              children: <Widget>[
                const Text('Belum punya akun?'),
                TextButton(
                  child: const Text(
                    'Buat akun baru',
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return RegisterPage();
                    }));
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}
