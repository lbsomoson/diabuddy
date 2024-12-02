import 'dart:convert';

import 'package:diabuddy/models/appointment_model.dart';
import 'package:diabuddy/models/medication_intake_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart' show rootBundle;

class DatabaseService {
  Future<void> printTableContents(String tableName) async {
    final db = await initializeDB();
    // Query all rows from the table
    List<Map<String, dynamic>> rows = await db.query(tableName);

    // Print the results to the console
    print('Contents of $tableName:');
    for (var row in rows) {
      print(row);
    }
  }

  Future<void> printTableSchema(String tableName) async {
    final db = await initializeDB();

    // Query the sqlite_master table for the schema of the table
    List<Map<String, dynamic>> result =
        await db.rawQuery("SELECT sql FROM sqlite_master WHERE type = 'table' AND name = ?", [tableName]);

    // Check if the table exists and print its schema
    if (result.isNotEmpty) {
      String schema = result.first['sql'];
      print('Schema of table $tableName:');
      print(schema);
    } else {
      print('Table $tableName does not exist in the database.');
    }
  }

  Future<Database> initializeDB() async {
    // deleteDatabase(join(await getDatabasesPath(), 'diabuddy_database.db'));

    // Open the database and store the reference.
    final database = openDatabase(
      join(await getDatabasesPath(), 'diabuddy_database.db'),
      onCreate: (db, version) async {
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
        await db.execute('''
          CREATE TABLE appointments(
            appointmentId INTEGER PRIMARY KEY AUTOINCREMENT,
            userId TEXT NOT NULL,
            channelId INTEGER NOT NULL,
            title TEXT NOT NULL,
            doctorName TEXT NOT NULL,
            clinicName TEXT NOT NULL,
            date INTEGER NOT NULL
          )
          ''');
        await db.execute('''
          CREATE TABLE metadata(
            key TEXT PRIMARY KEY,
            value TEXT
          )
          ''');
        await db.execute('''
          CREATE TABLE meals(
          mealId INTEGER PRIMARY KEY AUTOINCREMENT,
          mealName TEXT NOT NULL,
          foodCode TEXT,
          carbohydrate REAL,
          totalDietaryFiber REAL,
          totalSugar REAL,
          protein REAL,
          fat REAL,
          energy REAL,
          sodium REAL,
          cholesterol REAL,
          calcium REAL,
          phosphorus REAL,
          iron REAL,
          potassium REAL,
          zinc REAL,
          retinol REAL,
          betaCarotene REAL,
          thiamin REAL,
          riboflavin REAL,
          niacin REAL,
          vitaminC REAL,
          glycemicIndex REAL,
          diversityScore REAL,
          phytochemicalIndex REAL,
          heiClassification TEXT,
          healthyEatingIndex REAL
        );
        ''');
      },
      version: 1,
    );

    return database;
  }

  // ================================== MEDICATION_INTAKE CRUD OPERATIONS ==================================

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

  // ================================== APPOINTMENTS CRUD OPERATIONS ==================================

  // define a function that inserts appointment into the database
  Future<int> insertAppointment(Appointment appointment) async {
    // get a reference to the database
    final db = await initializeDB();

    return await db.insert(
      'appointments',
      appointment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the appointments belonging to a userId
  Future<List<Appointment>> getAppointments(String userId) async {
    final db = await initializeDB();

    final List<Map<String, dynamic>> maps = await db.query(
      'appointments',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    // Convert the List<Map<String, dynamic> into a List<MedicationIntake>.
    return List.generate(maps.length, (i) {
      return Appointment(
          appointmentId: maps[i]['appointmentId'].toString(),
          channelId: maps[i]['channelId'],
          userId: maps[i]['userId'],
          title: maps[i]['title'],
          doctorName: maps[i]['doctorName'],
          clinicName: maps[i]['clinicName'],
          date: DateTime.fromMillisecondsSinceEpoch(maps[i]['date']));
    });
  }

  Future<void> updateAppointment(Appointment appointment, String appointmentId) async {
    try {
      final db = await initializeDB();

      // Prepare the updated data for the medication
      Map<String, dynamic> updatedData = appointment.toMap();

      // Update the medication record in the database
      await db.update(
        'appointments',
        updatedData,
        where: 'appointmentId = ?',
        whereArgs: [appointmentId],
      );

      print("Appointment updated successfully");
    } catch (e) {
      print("Error: $e");
    }
  }

  // A method that deletes a receipt given an id.
  Future<void> deleteAppointment(int appointmentId) async {
    final db = await initializeDB();

    await db.delete(
      'appointments',
      where: 'appointmentId = ?',
      whereArgs: [appointmentId],
    );
  }

  // ================================== MEALS CRUD OPERATIONS ==================================
  Future<Map<String, dynamic>> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/cleaned_meal2.json');
    print("jsonString::: $jsonString");
    return jsonDecode(jsonString);
  }

  Future<void> uploadJsonDataToSQLite(Database database) async {
    // Check if the data has already been loaded (can be done with a metadata table or flag)
    var result = await database.rawQuery("SELECT 1 FROM sqlite_master WHERE name = 'metadata'");
    print(result);
    if (result.isNotEmpty) {
      print('Data from SQLITE has already been loaded.');
      return;
    }

    // Load JSON data
    Map<String, dynamic> jsonData = await loadJsonData();
    List<dynamic> meals = jsonData['meals'];

    print("meals:::::::: $meals");

    for (var meal in meals) {
      await database.insert('meals', {
        'mealName': meal['Meal Name'],
        'foodCode': meal['Food Code'],
        'carbohydrate': meal['Carbohydrate'],
        'totalDietaryFiber': meal['Total Dietary Fiber'],
        'totalSugar': meal['Total Sugar'],
        'protein': meal['Protein'],
        'fat': meal['Fat'],
        'energy': meal['Energy (Kcal)'],
        'sodium': meal['Sodium'].join(', '),
        'cholesterol': meal['Cholesterol'],
        'calcium': meal['Calcium'],
        'phosphorus': meal['Phosphorus'],
        'iron': meal['Iron'],
        'potassium': meal['Potassium'],
        'zinc': meal['Zinc'],
        'retinol': meal['Retinol'],
        'betaCarotene': meal['beta-carotene'],
        'thiamin': meal['Thiamin'],
        'riboflavin': meal['Riboflavin'],
        'niacin': meal['Niacin'],
        'vitaminC': meal['Vitamin C'],
        'glycemicIndex': meal['Glycemic Index'],
        'diversityScore': meal['Diversity Score'],
        'phytochemicalIndex': meal['Phytochemical Index'],
        'heiClassification': meal['HEI Classification'],
        'healthyEatingIndex': meal['Healthy Eating Index'],
      });
    }

    print("UPLOADED DATA IN MEALS TABLE");

    // Mark as loaded (optional, via metadata table or flag)
    await database.execute("CREATE TABLE IF NOT EXISTS metadata (key TEXT PRIMARY KEY, value TEXT)");
    await database.insert('metadata', {'key': 'dataLoaded', 'value': 'true'});

    print('Data from SQLITE loaded successfully.');
  }
}
