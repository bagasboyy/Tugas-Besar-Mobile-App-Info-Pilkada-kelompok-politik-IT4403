import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "komponen.dart" as dataglobal;
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(EditProfilePage());
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  final _users = FirebaseFirestore.instance.collection('users');
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _user = FirebaseFirestore.instance
      .collection('users')
      .where('username', isEqualTo: dataglobal.username)
      .limit(1)
      .snapshots();

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _emailController.text = documentSnapshot['email'];
      _nameController.text = documentSnapshot['nama'];
      _usernameController.text = documentSnapshot['username'];
      _passwordController.text = documentSnapshot['password'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'email'),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                ),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String email = _emailController.text;
                    final String name = _nameController.text;
                    final String username = _usernameController.text;
                    final String password = _passwordController.text;

                    if (email != null) {
                      await _users.doc(documentSnapshot!.id).update({
                        "email": email,
                        "nama": name,
                        "username": username,
                        "password": password
                      });

                      _emailController.text = '';
                      _nameController.text = '';
                      _usernameController.text = '';
                      _passwordController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profil"),
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 1,
      ),
      bottomNavigationBar: null,
      body: StreamBuilder(
        stream: _user,
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Container(
                  padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 80.0,
                                backgroundImage: _imageFile == null
                                    ? null
                                    : FileImage(File(_imageFile!.path))
                                        as ImageProvider<Object>?,
                                child: Icon(Icons.person),
                              ),
                              Positioned(
                                bottom: 20.0,
                                right: 20.0,
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: ((builder) => bottomSheet()),
                                    );
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.teal,
                                    size: 28.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            enabled: false,
                            autocorrect: false,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: documentSnapshot['email'],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            controller: _emailController,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            enabled: false,
                            autocorrect: false,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: documentSnapshot['nama'],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            controller: _nameController,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            enabled: false,
                            autocorrect: false,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: documentSnapshot['username'],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            controller: _usernameController,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            enabled: false,
                            autocorrect: false,
                            autofocus: true,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: documentSnapshot['password'],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            controller: _passwordController,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _update(documentSnapshot);
                          },
                          child: Text(
                            "EDIT",
                            style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }
}
