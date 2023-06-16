import 'package:flutter/material.dart';
import 'package:main/pages/edit_profile.dart';
import 'dart:io';
import 'package:main/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "komponen.dart" as dataglobal;

void main() {
  runApp(const ProfilPage());
}

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final _users = FirebaseFirestore.instance
      .collection('users')
      .where('username', isEqualTo: dataglobal.username)
      .limit(1)
      .snapshots();

  Future<void> _delete(String userId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content:
              const Text('Apakah Anda yakin ingin menghapus pengguna ini?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Iya'),
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .delete();

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Sukses'),
                        content: const Text('Pengguna berhasil dihapus.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_) {
                                return LoginPage();
                              }));
                            },
                          ),
                        ],
                      );
                    },
                  );
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text(
                            'Terjadi kesalahan saat menghapus pengguna.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void exitApplication() {
    // Exit the application
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Profil"),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: [
            Padding(
              padding: EdgeInsets.all(7),
              child: Image.asset(
                "assets/logo_kpu.png",
              ),
            )
          ],
        ),
        body: StreamBuilder(
          stream: _users,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot document = snapshot.data!.docs[index];
                  final Map<String, dynamic>? data =
                      document.data() as Map<String, dynamic>?;

                  if (data != null &&
                      data.containsKey('nama') &&
                      data.containsKey('email')) {
                    final String nama = data['nama'] ?? '';
                    final String email = data['email'] ?? '';

                    return Column(
                      children: [
                        Card(
                          color: Colors.red[500],
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 40,
                                      child: Icon(Icons.person),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(nama,
                                        style: TextStyle(color: Colors.white)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      email,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfilePage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(350, 40),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(
                                  10), // Ubah bentuk jadi rounded
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.edit, size: 20, color: Colors.black),
                              SizedBox(
                                width: 15,
                              ),
                              Text("Edit Profil",
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _delete(document.id);
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(350, 40),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(
                                  10), // Ubah bentuk jadi rounded
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 20, color: Colors.black),
                              SizedBox(
                                width: 15,
                              ),
                              Text("Hapus Akun",
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                              exitApplication();
                            },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(350, 40),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(
                                  10), // Ubah bentuk jadi rounded
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.output_rounded,
                                  size: 20, color: Colors.red),
                              SizedBox(
                                width: 15,
                              ),
                              Text("Keluar",
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        )
                      ],
                    );
                  } else {
                    return SizedBox(); // Mengembalikan widget kosong jika data tidak valid
                  }
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
