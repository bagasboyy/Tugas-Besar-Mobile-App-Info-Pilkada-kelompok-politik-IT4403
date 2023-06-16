// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'sql_helper.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   String path = await getDatabasesPath();
//   String databasePath = join(path, 'my_database.db');

//   // Membuat atau membuka database
//   Database database = await openDatabase(
//     databasePath,
//     version: 1,
//     onCreate: (Database db, int version) {
//       // Membuat tabel ketika database dibuat
//       db.execute('''
//         CREATE TABLE my_table (
//           _id INTEGER PRIMARY KEY,
//           name TEXT NOT NULL,
//           age INTEGER NOT NULL
//         )
//       ''');
//     },
//   );

//   // Menambahkan data ke tabel
//   await database.insert('my_table', {'name': 'John Doe', 'age': 25});

//   // Mengambil semua data dari tabel
//   List<Map<String, dynamic>> data = await database.query('my_table');

//   // Menampilkan data
//   for (Map<String, dynamic> row in data) {
//     print('Name: ${row['name']}, Age: ${row['age']}');
//   }

//   // Menutup database
//   await database.close();

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'SQLite Demo',
//       home: Scaffold(
//         appBar: AppBar(title: Text('SQLite Demo')),
//         body: Center(
//           child: Text('SQLite Demo'),
//         ),
//       ),
//     );
//   }
// }
