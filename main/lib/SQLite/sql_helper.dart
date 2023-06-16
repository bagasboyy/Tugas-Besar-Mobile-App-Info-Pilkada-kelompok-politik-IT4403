// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   static final _databaseName = 'my_database.db';
//   static final _databaseVersion = 1;

//   static final table = 'my_table';
//   static final columnId = '_id';
//   static final columnName = 'name';
//   static final columnAge = 'age';

//   // Membuat singleton instance DatabaseHelper
//   DatabaseHelper._privateConstructor();
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

//   // Referensi database
//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }

//     // Jika database belum ada, buat database baru
//     _database = await _initDatabase();
//     return _database!;
//   }

//   // Inisialisasi database
//   _initDatabase() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, _databaseName);
//     return await openDatabase(path,
//         version: _databaseVersion, onCreate: _onCreate);
//   }

//   // Membuat tabel dalam database
//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE $table (
//         $columnId INTEGER PRIMARY KEY,
//         $columnName TEXT NOT NULL,
//         $columnAge INTEGER NOT NULL
//       )
//     ''');
//   }

//   // Operasi CRUD

//   // Mengambil semua data dari tabel
//   Future<List<Map<String, dynamic>>> getAllData() async {
//     Database db = await instance.database;
//     return await db.query(table);
//   }

//   // Menambahkan data ke tabel
//   Future<int> insertData(String name, int age) async {
//     Database db = await instance.database;
//     Map<String, dynamic> row = {
//       columnName: name,
//       columnAge: age,
//     };
//     return await db.insert(table, row);
//   }

//   // Mengupdate data di tabel
//   Future<int> updateData(int id, String name, int age) async {
//     Database db = await instance.database;
//     Map<String, dynamic> row = {
//       columnName: name,
//       columnAge: age,
//     };
//     String whereClause = '$columnId = ?';
//     List<dynamic> whereArgs = [id];
//     return await db.update(table, row, where: whereClause, whereArgs: whereArgs);
//   }

//   // Menghapus data dari tabel
//   Future<int> deleteData(int id) async {
//     Database db = await instance.database;
//     String whereClause = '$columnId = ?';
//     List<dynamic> whereArgs = [id];
//     return await db.delete(table, where: whereClause, whereArgs: whereArgs);
//   }
// }
