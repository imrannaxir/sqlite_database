import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:sqlite_database/notes.dart';

class DBHelper extends Sqflite {
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentDirectory.path, 'notes.db');
    var db = await openDatabase(path, onCreate: _onCreate,version: 1);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL , age INTEGER NOT NULL , description TEXT NOT NULL , email TEXT)',
      
    );
   
  }

  Future<bool> insert(NotesModel notesModel) async {
    var dbClient = await db;
    int rowIndex = await dbClient!.insert('notes', notesModel.toMap());
    if (rowIndex > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<NotesModel>> getNotesList() async {
    var dbClient = _db;

    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('notes');

    return queryResult.map((e) {
      return NotesModel.fromMap(e);
    }).toList();
  }

  Future<int> update(NotesModel notesModel) async {
    var dbClient = _db;
    return await dbClient!.update(
      'notes',
      notesModel.toMap(),
      where: 'id = ?',
      whereArgs: [notesModel.id],
    );
  }

  Future<int> delete(int id) async {
    var dbClient = _db;
    return await dbClient!.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}


/**
 
  //
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper extends Sqflite {
  static Database? _db;
  static const dbName = 'DOGS';

  Future<Database> get database async {
    return _db ??= await openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );
  }

  fetchDogs() {}
}




import 'package:sqflite_database/dog.dart';

// // A method that retrieves all the dogs from the dogs table.

// Future<List<Dog>> fetchDogs(database) async {
//   print(await fetchDogs(database));

//   // Get a reference to the database.
//   final db = await database;

//   // Query the table for all The Dogs.
//   final List<Map<String, dynamic>> maps = await db.query('dogs');

//   // Convert the List<Map<String, dynamic> into a List<Dog>.
//   return List.generate(maps.length, (index) {
//     return Dog(
//       id: maps[index]['id'],
//       name: maps[index]['name'],
//       age: maps[index]['age'],
//     );
//   });
// }



import 'package:sqflite/sqflite.dart';
// import 'package:sqflite_database/dog.dart';

// //

// Future<void> insertDog(Dog dog, database) async {
//   final db = await database;

//   await db.insert(
//     'dogs',
//     dog.toMap(),
//     conflictAlgorithm: ConflictAlgorithm.replace,
//   );
// }

// var toni = Dog(id: 0, name: 'Toni', age: 15);



import 'package:sqflite_database/dog.dart';

import 'fetch.dart';

// When you want to update somethig in dogTable

Future<void> updateDog(Dog dog, database) async {
  final db = await database;
  await updateDog(toni, database);
  print(await fetchDogs(database));
  await db.update(
    'dogs',
    dog.toMap(),
    where: 'id = ?',
    whereArgs: [dog.id],
  );
}

dynamic toni = Dog(id: toni.id, name: toni.name, age: toni.age + 5);





Future<void> deleteDog(int id, database) async {
  final db = await database;

  await db.delete(
    'dogs',
    where: 'id = ?',
    whereArgs: [id],
  );
}

//dynamic toni = Dog(id: toni.id, name: toni.name, age: toni.age);



 */