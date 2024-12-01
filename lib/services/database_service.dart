import 'dart:convert';

import 'package:diabuddy/models/medication_intake_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  Future<Database> initializeDB() async {
    // Open the database and store the reference.
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'diabuddy_database.db'),
      // When the database is first created, create a table to store tasks.
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        await db.execute(
          '''
          CREATE TABLE medications(
            medicationId INTEGER PRIMARY KEY AUTOINCREMENT,
            userId TEXT NOT NULL,
            channelId INTEGER NOT NULL,
            name TEXT NOT NULL,
            time TEXT NOT NULL,
            dose TEXT NOT NULL,
            frequency TEXT NOT NULL,
            verifiedBy TEXT NOT NULL,
            isActive INTEGER NOT NULL
          )
        ''',
        );
      },
      version: 1,
    );

    return database;
  }

  // define a function that inserts medication into the database
  Future<int> insertMedication(MedicationIntake medicationIntake) async {
    // get a reference to the database
    final db = await initializeDB();

    return await db.insert(
      'medications',
      medicationIntake.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the medications belonging to a userId
  Future<List<MedicationIntake>> getMedications(String userId) async {
    final db = await initializeDB();

    final List<Map<String, dynamic>> maps = await db.query(
      'medications',
      where: 'userId = ? AND isActive = ?',
      whereArgs: [userId, 1],
    );

    // Convert the List<Map<String, dynamic> into a List<MedicationIntake>.
    return List.generate(maps.length, (i) {
      return MedicationIntake(
        medicationId: maps[i]['medicationId'].toString(),
        channelId: maps[i]['channelId'],
        userId: maps[i]['userId'],
        name: maps[i]['name'],
        time: List<String>.from(jsonDecode(maps[i]['time'])),
        dose: maps[i]['dose'],
        frequency: maps[i]['frequency'],
        verifiedBy: jsonDecode(maps[i]['verifiedBy']),
        isActive: maps[i]['isActive'] == 1 ? true : false,
      );
    });
  }

  // A method that retrieves all the inactive medicaitons belonging to a userId
  Future<List<MedicationIntake>> getInactiveMedications(String userId) async {
    final db = await initializeDB();

    final List<Map<String, dynamic>> maps = await db.query(
      'medications',
      where: 'userId = ? AND isActive = ?',
      whereArgs: [userId, 0],
    );

    // Convert the List<Map<String, dynamic> into a List<MedicationIntake>.
    return List.generate(maps.length, (i) {
      return MedicationIntake(
        medicationId: maps[i]['medicationId'].toString(),
        channelId: maps[i]['channelId'],
        userId: maps[i]['userId'],
        name: maps[i]['name'],
        time: List<String>.from(jsonDecode(maps[i]['time'])),
        dose: maps[i]['dose'],
        frequency: maps[i]['frequency'],
        verifiedBy: jsonDecode(maps[i]['verifiedBy']),
        isActive: maps[i]['isActive'] == 1 ? true : false,
      );
    });
  }

  // soft delete
  Future<void> deleteMedication(String medicationId) async {
    final db = await initializeDB();

    print("in soft delete medicaions");
    // update only the isActive field to false
    await db.update(
      'medications',
      {'isActive': 0}, // set the isActive field to false
      where: 'medicationId = ?',
      whereArgs: [medicationId],
    );
  }

  Future<void> updateMedication(MedicationIntake medication, String medicationId) async {
    try {
      final db = await initializeDB();

      // Prepare the updated data for the medication
      Map<String, dynamic> updatedData = medication.toMap();
      print(updatedData);

      // Update the medication record in the database
      await db.update(
        'medications',
        updatedData,
        where: 'medicationId = ?',
        whereArgs: [medicationId],
      );

      print("Medication updated successfully");
    } catch (e) {
      print("Error: $e");
    }
  }
}
