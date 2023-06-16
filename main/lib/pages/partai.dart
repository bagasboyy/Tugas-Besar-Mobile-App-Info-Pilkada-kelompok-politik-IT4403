import 'package:flutter/material.dart';
import 'package:main/main.dart';
import 'package:main/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(PartaiPage());
}

class PartaiPage extends StatelessWidget {
  CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection('Partai');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Partai Pemilu",
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
      body: ListView(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: itemsCollection.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

                  return Card(
                    margin: EdgeInsets.all(10),
                    color: Colors.red,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          //row
                          SingleChildScrollView(
                            child: Row(
                              children: [
                                Image.network(
                                  data['imageUrl'],
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data['Nama']}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "${data['Deskripsi']}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "${data['Peserta']}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                PopupMenuButton(
                                  color: Colors.white,
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: TextButton(
                                        onPressed: () => showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('Detail'),
                                            content: Wrap(
                                              children: [
                                                Center(
                                                    child: Image.network(
                                                      data[
                                                          'imageUrl'], // Gunakan URL gambar dari Firestore
                                                    ),
                                                  ),
                                                Text(
                                                  "${data['Deskripsi']}",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text("${data['Ketua']}"),
                                                Text("${data['Alamat']}"),
                                                Text("${data['Web']}"),
                                              ],
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Close'),
                                                child: const Text('Close'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        child: const Text(
                                          "Detail",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
