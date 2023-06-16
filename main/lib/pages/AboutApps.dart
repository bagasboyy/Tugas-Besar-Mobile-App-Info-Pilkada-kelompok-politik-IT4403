import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() {
  runApp(AboutAppsPage());
}

class AboutAppsPage extends StatelessWidget {
  AboutAppsPage({super.key});

  CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection('Tentang Aplikasi');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Tentang Aplikasi",
          style: TextStyle(color: Colors.white),
        ),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: itemsCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return Column(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              return Column(
                children: [
                  Card(
                    margin: EdgeInsets.all(15),
                    color: Colors.transparent,
                    elevation: 0.0,
                    child: SizedBox(
                      width: double.infinity,
                      height: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            data[
                                'imageUrl'], // Gunakan URL gambar dari Firestore
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 300,
                    width: 350,
                    child: Text(
                      "${data['deskripsi']}",
                      style: TextStyle(fontFamily: 'RobotoMono', fontSize: 20),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
