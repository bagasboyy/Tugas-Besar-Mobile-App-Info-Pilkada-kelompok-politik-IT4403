import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main/pages/login.dart';

// import 'package:passwordfield/passwordfield.dart';

void main() {
  runApp(RegisterPage());
}

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
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
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    autocorrect: false,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: "Email",
                    ),
                    controller: _emailController,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    autocorrect: false,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: "Nama Lengkap",
                    ),
                    controller: _nameController,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    autocorrect: false,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: "Username",
                    ),
                    controller: _usernameController,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    autocorrect: false,
                    autofocus: true,
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
                  height: 50,
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Daftar'),
                    onPressed: () => _register(),
                  ),
                ),
                Row(
                  children: <Widget>[
                    const Text('Sudah punya akun?'),
                    TextButton(
                      child: const Text(
                        'Masuk',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return LoginPage();
                        }));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            )),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Future<void> _register() async {
    final CollectionReference _users =
        FirebaseFirestore.instance.collection('users');

    final String name = _nameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String username = _usernameController.text;

    if (username.isEmpty || password.isEmpty || name.isEmpty || email.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Username, Password, Nama, dan Email harus diisi'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      _users.add({
        "email": email,
        "password": password,
        "nama": name,
        "username": username,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Berhasil daftar"),
          duration: Duration(seconds: 3),
        ),
      );
      Navigator.pop(context);
    }
    _usernameController.text = '';
    _passwordController.text = '';
    _nameController.text = '';
    _emailController.text = '';
  }
}
