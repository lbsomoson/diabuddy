import 'dart:convert';

import 'package:diabuddy/models/appointment_model.dart';
import 'package:diabuddy/models/daily_health_record_model.dart';
import 'package:diabuddy/models/meal_intake_model.dart';
import 'package:diabuddy/models/meal_model.dart';
import 'package:diabuddy/models/medication_intake_model.dart';
import 'package:diabuddy/models/user_model.dart';
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

  Future<void> seedUsersFromSQL() async {
    // Start date
    DateTime startDate = DateTime(2024, 11, 5, 0, 0, 0);

    // Generate 30 DateTime objects
    List<DateTime> dates = List.generate(
      30,
      (index) => startDate.add(Duration(days: index)),
    );

    final db = await initializeDB();
    List<Map<String, dynamic>> rs = [
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[0].millisecondsSinceEpoch,
        "healthyEatingIndex": 14.69,
        "diversityScore": 14.57,
        "glycemicIndex": 51.92,
        "carbohydrates": 646.24,
        "stepsCount": 1206.85,
        "energyKcal": 973.63
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[1].millisecondsSinceEpoch,
        "healthyEatingIndex": 3.48,
        "diversityScore": 6.04,
        "glycemicIndex": 261.09,
        "carbohydrates": 374.16,
        "stepsCount": 2268.56,
        "energyKcal": 1582.82
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[2].millisecondsSinceEpoch,
        "healthyEatingIndex": 7.56,
        "diversityScore": 16.23,
        "glycemicIndex": 97.53,
        "carbohydrates": 636.76,
        "stepsCount": 894.73,
        "energyKcal": 2328.85
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[3].millisecondsSinceEpoch,
        "healthyEatingIndex": 5.76,
        "diversityScore": 3.05,
        "glycemicIndex": 171.65,
        "carbohydrates": 405.47,
        "stepsCount": 452.68,
        "energyKcal": 189.46
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[4].millisecondsSinceEpoch,
        "healthyEatingIndex": 12.53,
        "diversityScore": 1.08,
        "glycemicIndex": 106.27,
        "carbohydrates": 209.55,
        "stepsCount": 6711.54,
        "energyKcal": 1761.15
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[5].millisecondsSinceEpoch,
        "healthyEatingIndex": 2.61,
        "diversityScore": 6.69,
        "glycemicIndex": 159.94,
        "carbohydrates": 129.51,
        "stepsCount": 4628.65,
        "energyKcal": 2740.94
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[6].millisecondsSinceEpoch,
        "healthyEatingIndex": 10.92,
        "diversityScore": 4.15,
        "glycemicIndex": 125.74,
        "carbohydrates": 454.59,
        "stepsCount": 3249.51,
        "energyKcal": 2975.9
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[7].millisecondsSinceEpoch,
        "healthyEatingIndex": 15.22,
        "diversityScore": 10.92,
        "glycemicIndex": 176.04,
        "carbohydrates": 155.3,
        "stepsCount": 5169.2,
        "energyKcal": 1446.23
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[8].millisecondsSinceEpoch,
        "healthyEatingIndex": 15.14,
        "diversityScore": 2.24,
        "glycemicIndex": 294.46,
        "carbohydrates": 466.31,
        "stepsCount": 5712.88,
        "energyKcal": 658.5
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[9].millisecondsSinceEpoch,
        "healthyEatingIndex": 14.84,
        "diversityScore": 2.51,
        "glycemicIndex": 191.48,
        "carbohydrates": 365.94,
        "stepsCount": 1469.65,
        "energyKcal": 463.75
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[10].millisecondsSinceEpoch,
        "healthyEatingIndex": 5.57,
        "diversityScore": 4.85,
        "glycemicIndex": 272.32,
        "carbohydrates": 54.61,
        "stepsCount": 4981.65,
        "energyKcal": 284.99
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[11].millisecondsSinceEpoch,
        "healthyEatingIndex": 16.93,
        "diversityScore": 5.49,
        "glycemicIndex": 117.13,
        "carbohydrates": 396.41,
        "stepsCount": 5684.04,
        "energyKcal": 2214.42
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[12].millisecondsSinceEpoch,
        "healthyEatingIndex": 12.35,
        "diversityScore": 12.47,
        "glycemicIndex": 137.09,
        "carbohydrates": 234.26,
        "stepsCount": 6734.56,
        "energyKcal": 1913.36
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[13].millisecondsSinceEpoch,
        "healthyEatingIndex": 16.22,
        "diversityScore": 12.24,
        "glycemicIndex": 90.75,
        "carbohydrates": 367.05,
        "stepsCount": 43.95,
        "energyKcal": 1232.3
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[14].millisecondsSinceEpoch,
        "healthyEatingIndex": 1.14,
        "diversityScore": 13.91,
        "glycemicIndex": 135.83,
        "carbohydrates": 434.88,
        "stepsCount": 376.57,
        "energyKcal": 1836.52
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[15].millisecondsSinceEpoch,
        "healthyEatingIndex": 11.69,
        "diversityScore": 2.92,
        "glycemicIndex": 198.37,
        "carbohydrates": 222.81,
        "stepsCount": 2273.28,
        "energyKcal": 2331.76
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[16].millisecondsSinceEpoch,
        "healthyEatingIndex": 1.86,
        "diversityScore": 1.06,
        "glycemicIndex": 162.1,
        "carbohydrates": 11.76,
        "stepsCount": 6499.56,
        "energyKcal": 2485.56
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[17].millisecondsSinceEpoch,
        "healthyEatingIndex": 3.12,
        "diversityScore": 13.21,
        "glycemicIndex": 33.75,
        "carbohydrates": 299.15,
        "stepsCount": 938.02,
        "energyKcal": 1619.83
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[18].millisecondsSinceEpoch,
        "healthyEatingIndex": 4.23,
        "diversityScore": 13.16,
        "glycemicIndex": 52.48,
        "carbohydrates": 245.84,
        "stepsCount": 966.72,
        "energyKcal": 493.98
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[19].millisecondsSinceEpoch,
        "healthyEatingIndex": 16.95,
        "diversityScore": 3.64,
        "glycemicIndex": 133.89,
        "carbohydrates": 562.07,
        "stepsCount": 3274.94,
        "energyKcal": 2254.06
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[20].millisecondsSinceEpoch,
        "healthyEatingIndex": 19.83,
        "diversityScore": 16.4,
        "glycemicIndex": 86.72,
        "carbohydrates": 177.41,
        "stepsCount": 176.36,
        "energyKcal": 1596.54
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[21].millisecondsSinceEpoch,
        "healthyEatingIndex": 9.16,
        "diversityScore": 3.62,
        "glycemicIndex": 272.12,
        "carbohydrates": 156.3,
        "stepsCount": 3860.22,
        "energyKcal": 2484.33
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[22].millisecondsSinceEpoch,
        "healthyEatingIndex": 15.47,
        "diversityScore": 11.25,
        "glycemicIndex": 204.38,
        "carbohydrates": 22.05,
        "stepsCount": 4857.88,
        "energyKcal": 2013.98
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[23].millisecondsSinceEpoch,
        "healthyEatingIndex": 8.74,
        "diversityScore": 17.15,
        "glycemicIndex": 46.6,
        "carbohydrates": 646.72,
        "stepsCount": 6083.37,
        "energyKcal": 2736.12
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[24].millisecondsSinceEpoch,
        "healthyEatingIndex": 12.66,
        "diversityScore": 6.45,
        "glycemicIndex": 146.45,
        "carbohydrates": 500.38,
        "stepsCount": 6931.77,
        "energyKcal": 1487.42
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[25].millisecondsSinceEpoch,
        "healthyEatingIndex": 5.15,
        "diversityScore": 6.8,
        "glycemicIndex": 270.8,
        "carbohydrates": 612.49,
        "stepsCount": 3365.13,
        "energyKcal": 1399.59
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[26].millisecondsSinceEpoch,
        "healthyEatingIndex": 5.46,
        "diversityScore": 9.14,
        "glycemicIndex": 65.5,
        "carbohydrates": 518.08,
        "stepsCount": 6590.05,
        "energyKcal": 2428.26
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[27].millisecondsSinceEpoch,
        "healthyEatingIndex": 9.15,
        "diversityScore": 10.69,
        "glycemicIndex": 231.76,
        "carbohydrates": 327.56,
        "stepsCount": 162.96,
        "energyKcal": 2873.94
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[28].millisecondsSinceEpoch,
        "healthyEatingIndex": 9.08,
        "diversityScore": 13.11,
        "glycemicIndex": 43.61,
        "carbohydrates": 456.04,
        "stepsCount": 5813.09,
        "energyKcal": 275.12
      },
      {
        "userId": "0rIfWK6bugRNYZMDViysBHQbDiw1",
        "date": dates[29].millisecondsSinceEpoch,
        "healthyEatingIndex": 6.31,
        "diversityScore": 9.14,
        "glycemicIndex": 257.94,
        "carbohydrates": 512.01,
        "stepsCount": 5552.91,
        "energyKcal": 1208.42
      }
    ];

    try {
      // Insert each user into the app_users table
      for (var r in rs) {
        await db.insert(
          'records',
          r,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      print("Successfully seeded users from SQL file");
    } catch (e) {
      print("Error seeding users from SQL file: $e");
    }
  }

  Future<Database> initializeDB() async {
    // deleteDatabase(join(await getDatabasesPath(), 'diabuddy_database.db'));

    // Open the database and store the reference.
    final database = openDatabase(
      join(await getDatabasesPath(), 'diabuddy_database.db'),
      version: 1,
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
          energyKcal REAL,
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
          glycemicLoad REAL,
          diversityScore REAL,
          phytochemicalIndex REAL,
          heiClassification TEXT,
          healthyEatingIndex REAL
        );
        ''');
        await db.execute('''
          CREATE TABLE meal_intakes(
            mealIntakeId INTEGER PRIMARY KEY AUTOINCREMENT,
            userId TEXT NOT NULL,
            imageBytes BLOB NOT NULL,
            timestamp INTEGER NOT NULL,
            foodIds TEXT NOT NULL,
            mealTime TEXT NOT NULL,
            accMeals TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE records(
            recordId INTEGER PRIMARY KEY AUTOINCREMENT,
            userId TEXT NOT NULL,
            date INTEGER NOT NULL,
            healthyEatingIndex REAL NOT NULL,
            diversityScore REAL NOT NULL,
            glycemicIndex REAL NOT NULL,
            carbohydrates REAL NOT NULL,
            energyKcal REAL NOT NULL,
            stepsCount REAL NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE app_users(
            userId INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT,
            age INTEGER,
            gender TEXT,
            activityLevel TEXT,
            height REAL,
            weight REAL,
            dailyCalorieIntake INTEGER
          )
        ''');
      },
    );

    return database;
  }

  // ================================== APPUSER CRUD OPERATIONS ==================================

  // define a function that inserts medication into the database
  Future<int> insertUser(AppUser appUser) async {
    // get a reference to the database
    final db = await initializeDB();

    return await db.insert(
      'app_users',
      appUser.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<AppUser?> getUserInfo(String userId) async {
    final db = await initializeDB();

    // Query the meals table where the mealName matches
    List<Map<String, dynamic>> result = await db.query(
      'app_users',
      where: 'userId = ?',
      whereArgs: [userId],
      limit: 1,
    );

    // If a result is found, return a Meal object
    if (result.isNotEmpty) {
      Map<String, dynamic> appUser = result.first;
      return AppUser.fromJson(appUser);
    }

    // Return null if no meal is found
    return null;
  }

  Future<void> updateUserDetails(String userId, AppUser appUser) async {
    // get a reference to the database
    final db = await initializeDB();

    final List<Map<String, dynamic>> existingUsers =
        await db.query('app_users', where: 'userId = ?', whereArgs: [userId], limit: 1);

    if (existingUsers.isNotEmpty) {
      // Extract the existing record data
      final Map<String, dynamic> existingData = existingUsers.first;

      // Merge the existing data with the new data
      final Map<String, dynamic> updatedData = {
        ...existingData,
        ...appUser.toMap(),
      };

      // Update the record in the database
      await db.update(
        'app_users',
        updatedData,
        where: 'userId = ?',
        whereArgs: [existingData['userId']],
      );

      print('Record updated successfully.');
    } else {
      // Handle the case where no matching record exists
      print('No existing record found for the specified date and userId.');
    }
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

  // ================================== MEAL CRUD OPERATIONS ==================================
  Future<Map<String, dynamic>> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/cleaned_meal2.json');
    return jsonDecode(jsonString);
  }

  Future<void> uploadJsonDataToSQLite(Database database) async {
    // Check if data is already loaded
    var result = await database.query(
      'metadata',
      where: 'key = ?',
      whereArgs: ['dataLoaded'],
    );

    if (result.isNotEmpty && result.first['value'] == 'true') {
      print('Meals data is already loaded. Skipping insertion.');
      return;
    }

    // Load JSON data
    Map<String, dynamic> jsonData = await loadJsonData();
    List<dynamic> meals = jsonData['meals'];

    for (var meal in meals) {
      await database.insert('meals', {
        'mealName': meal['Meal Name'],
        'foodCode': meal['Food Code'],
        'carbohydrate': meal['Carbohydrate'],
        'totalDietaryFiber': meal['Total Dietary Fiber'],
        'totalSugar': meal['Total Sugar'],
        'protein': meal['Protein'],
        'fat': meal['Fat'],
        'energyKcal': meal['Energy (Kcal)'],
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
        'glycemicLoad': meal['Glycemic Load'],
        'diversityScore': meal['Diversity Score'],
        'phytochemicalIndex': meal['Phytochemical Index'],
        'heiClassification': meal['HEI Classification'],
        'healthyEatingIndex': meal['Healthy Eating Index'],
      });
    }

    // Mark as loaded (optional, via metadata table or flag)
    await database.execute("CREATE TABLE IF NOT EXISTS metadata (key TEXT PRIMARY KEY, value TEXT)");
    await database.insert('metadata', {'key': 'dataLoaded', 'value': 'true'});

    print('Data from SQLITE loaded successfully.');
  }

  // A method that retrieves all the meals
  Future<List<Meal>> getMeals() async {
    final db = await initializeDB();

    final List<Map<String, dynamic>> maps = await db.query('meals');

    // Convert the List<Map<String, dynamic> into a List<Meal>.
    return List.generate(maps.length, (i) {
      List<double?>? sodium;
      if (maps[i]['sodium'] is String) {
        sodium = List<double?>.from(maps[i]['sodium']?.split(', ').map((e) => double.tryParse(e.trim())) ?? []);
      } else if (maps[i]['sodium'] is List) {
        sodium = (maps[i]['sodium'] as List<dynamic>?)
            ?.map((e) => e != null ? double.tryParse(e.toString()) : null)
            .toList();
      }

      return Meal(
        mealId: maps[i]['mealId'].toString(),
        mealName: maps[i]['mealName'] ?? maps[i]['Meal Name'],
        foodCode: maps[i]['foodCode'] ?? maps[i]['Food Code'],
        carbohydrate: maps[i]['carbohydrate']?.toDouble() ?? maps[i]['Carbohydrate']?.toDouble(),
        totalDietaryFiber: maps[i]['totalDietaryFiber']?.toDouble() ?? maps[i]['Total Dietary Fiber']?.toDouble(),
        totalSugar: maps[i]['totalSugar']?.toDouble() ?? maps[i]['Total Sugar']?.toDouble(),
        protein: maps[i]['protein']?.toDouble() ?? maps[i]['Protein']?.toDouble(),
        fat: maps[i]['fat']?.toDouble() ?? maps[i]['Fat']?.toDouble(),
        energyKcal: maps[i]['energyKcal']?.toDouble() ?? maps[i]['Energy (Kcal)']?.toDouble(),
        sodium: sodium,
        cholesterol: maps[i]['cholesterol']?.toDouble() ?? maps[i]['Cholesterol']?.toDouble(),
        calcium: maps[i]['calcium']?.toDouble() ?? maps[i]['Calcium']?.toDouble(),
        phosphorus: maps[i]['phosphorus']?.toDouble() ?? maps[i]['Phosphorus']?.toDouble(),
        iron: maps[i]['iron']?.toDouble() ?? maps[i]['Iron']?.toDouble(),
        potassium: maps[i]['potassium']?.toDouble() ?? maps[i]['Potassium']?.toDouble(),
        zinc: maps[i]['zinc']?.toDouble() ?? maps[i]['Zinc']?.toDouble(),
        retinol: maps[i]['retinol']?.toDouble() ?? maps[i]['Retinol']?.toDouble(),
        betaCarotene: maps[i]['betaCarotene']?.toDouble() ?? maps[i]['beta-carotene']?.toDouble(),
        thiamin: maps[i]['thiamin']?.toDouble() ?? maps[i]['Thiamin']?.toDouble(),
        riboflavin: maps[i]['riboflavin']?.toDouble() ?? maps[i]['Riboflavin']?.toDouble(),
        niacin: maps[i]['niacin']?.toDouble() ?? maps[i]['Niacin']?.toDouble(),
        vitaminC: maps[i]['vitaminC']?.toDouble() ?? maps[i]['Vitamin C']?.toDouble(),
        glycemicIndex: maps[i]['glycemicIndex']?.toDouble() ?? maps[i]['Glycemic Index']?.toDouble(),
        diversityScore: maps[i]['diversityScore']?.toDouble() ?? maps[i]['Diversity Score']?.toDouble(),
        phytochemicalIndex: maps[i]['phytochemicalIndex']?.toDouble() ?? maps[i]['Phytochemical Index']?.toDouble(),
        healthyEatingIndex: maps[i]['healthyEatingIndex']?.toDouble() ?? maps[i]['Healthy Eating Index']?.toDouble(),
        heiClassification: maps[i]['heiClassification'] ?? maps[i]['HEI Classification'],
      );
    });
  }

  Future<Meal?> getMeal(String mealName) async {
    final db = await initializeDB();

    // Query the meals table where the mealName matches
    List<Map<String, dynamic>> result = await db.query(
      'meals',
      where: 'mealName = ?',
      whereArgs: [mealName],
      limit: 1,
    );

    // If a result is found, return a Meal object
    if (result.isNotEmpty) {
      Map<String, dynamic> mealData = result.first;
      return Meal.fromJson(mealData, mealData['mealId'].toString());
    }

    // Return null if no meal is found
    return null;
  }

  // ================================== MEAL_INTAKES CRUD OPERATIONS ==================================

  // define a function that inserts meal_intake into the database
  Future<int> insertMealIntake(MealIntake mealIntake) async {
    // get a reference to the database
    final db = await initializeDB();

    try {
      return await db.insert(
        'meal_intakes',
        mealIntake.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('error in insert meal intake: $e');
    }
    return 0;
  }

  // A method that retrieves all the meal_intakes belonging to a userId
  Future<List<MealIntake>> getMealIntakes(String userId) async {
    final db = await initializeDB();

    final List<Map<String, dynamic>> maps = await db.query(
      'meal_intakes',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    // Convert the List<Map<String, dynamic> into a List<MealIntake>.
    return List.generate(maps.length, (i) {
      return MealIntake(
        mealIntakeId: maps[i]['mealIntakeId'].toString(),
        userId: maps[i]['userId'],
        foodIds: List<String>.from(jsonDecode(maps[i]['foodIds'])),
        imageBytes: base64Decode(maps[i]['imageBytes']),
        timestamp: DateTime.fromMillisecondsSinceEpoch(maps[i]['timestamp']),
        mealTime: maps[i]['mealTime'],
        accMeals: Meal.fromJson(maps[i]['accMeals'], maps[i]['mealIntakeId'].toString()),
      );
    });
  }

  Future<MealIntake?> getMealIntake(String mealIntakeId) async {
    final db = await initializeDB();

    // Query the meals table where the mealName matches
    List<Map<String, dynamic>> result = await db.query(
      'meal_intakes',
      where: 'mealIntakeId = ?',
      whereArgs: [mealIntakeId],
      limit: 1,
    );

    // If a result is found, return a Meal object
    if (result.isNotEmpty) {
      Map<String, dynamic> mealIntake = result.first;
      return MealIntake.fromMap(mealIntake);
    }
    return null;
  }

  Future<List<MealIntake>> getMealIntakesByDate(String userId, DateTime date) async {
    final db = await initializeDB();

    // Calculate the start and end of the specified date
    final startOfDay = DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
    final endOfDay = startOfDay + const Duration(days: 1).inMilliseconds;

    // Execute the query
    final List<Map<String, dynamic>> maps = await db.query(
      'meal_intakes',
      where: 'userId = ? AND timestamp >= ? AND timestamp < ?',
      whereArgs: [userId, startOfDay, endOfDay],
    );

    // Convert the List<Map<String, dynamic> into a List<MealIntake>.
    return List.generate(maps.length, (i) {
      return MealIntake(
        mealIntakeId: maps[i]['mealIntakeId'].toString(),
        userId: maps[i]['userId'],
        foodIds: maps[i]['foodIds'].split(', '),
        imageBytes: base64Decode(maps[i]['imageBytes']),
        timestamp: DateTime.fromMillisecondsSinceEpoch(maps[i]['timestamp']),
        mealTime: maps[i]['mealTime'],
        accMeals: maps[i]['accMeals'] != null
            ? Meal.fromJson(jsonDecode(maps[i]['accMeals']), maps[i]['mealIntakeId'].toString())
            : null,
      );
    });
  }

  // ================================== DAILY HEALTH RECORD CRUD OPERATIONS ==================================

  // define a function that inserts meal_intake into the database
  Future<void> insertRecord(DailyHealthRecord record) async {
    try {
      // Get a reference to the database
      final db = await initializeDB();

      // Define the start and end of the day for the record's date
      final int startOfDay = DateTime(record.date.year, record.date.month, record.date.day).millisecondsSinceEpoch;
      final int endOfDay = startOfDay + const Duration(days: 1).inMilliseconds;

      // Check if a record with the same `userId` and `date` already exists
      final List<Map<String, dynamic>> existingRecords = await db.query(
        'records',
        where: 'userId = ? AND date >= ? AND date < ?',
        whereArgs: [record.userId, startOfDay, endOfDay],
        limit: 1,
      );

      if (existingRecords.isNotEmpty) {
        print('Record already exists for this user on the specified date.');
        return;
      }

      // Add the new record if no duplicate exists
      await db.insert(
        'records',
        record.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      print('Record added successfully.');
    } catch (e) {
      print('Error adding record: $e');
    }
  }

  Future<void> updateRecord(DailyHealthRecord record) async {
    try {
      // Get a reference to the database
      final db = await initializeDB();

      // Define the start and end of the day for the record's date
      final int startOfDay = DateTime(record.date.year, record.date.month, record.date.day).millisecondsSinceEpoch;
      final int endOfDay = startOfDay + const Duration(days: 1).inMilliseconds;

      // Query for the existing record with the same `userId` and date range
      final List<Map<String, dynamic>> existingRecords = await db.query(
        'records', // Table name
        where: 'userId = ? AND date >= ? AND date < ?',
        whereArgs: [record.userId, startOfDay, endOfDay],
        limit: 1,
      );

      if (existingRecords.isNotEmpty) {
        // Extract the existing record data
        final Map<String, dynamic> existingData = existingRecords.first;

        // Merge the existing data with the new data
        final Map<String, dynamic> updatedData = {
          ...existingData,
          ...record.toMap(),
          'healthyEatingIndex': (existingData['healthyEatingIndex'] as num) + record.healthyEatingIndex,
          'glycemicIndex': (existingData['glycemicIndex'] as num) + record.glycemicIndex,
          'carbohydrates': (existingData['carbohydrates'] as num) + record.carbohydrates,
          'energyKcal': (existingData['energyKcal'] as num) + record.energyKcal,
          'diversityScore': (existingData['diversityScore'] as num) + record.diversityScore,
        };

        // Update the record in the database
        await db.update(
          'records',
          updatedData,
          where: 'recordId = ?',
          whereArgs: [existingData['recordId']],
        );

        print('Record updated successfully.');
      } else {
        // Handle the case where no matching record exists
        print('No existing record found for the specified date and userId.');
      }
    } catch (e) {
      // Handle exceptions
      print('An error occurred: $e');
    }
  }

  Future<DailyHealthRecord?> getRecordByDate(String id, DateTime date) async {
    try {
      // Get a reference to the database
      final db = await initializeDB();

      // Calculate the start and end of the specified date
      final int startOfDay = DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
      final int endOfDay = startOfDay + const Duration(days: 1).inMilliseconds;

      // Query the database for a record that matches the criteria
      final List<Map<String, dynamic>> records = await db.query(
        'records',
        where: 'userId = ? AND date >= ? AND date < ?',
        whereArgs: [id, startOfDay, endOfDay],
        limit: 1,
      );

      // Check if a record was found
      if (records.isNotEmpty) {
        // Convert the record data into a `DailyHealthRecord` object
        final recordData = records.first;
        return DailyHealthRecord.fromMap(recordData);
      } else {
        // Return null if no record was found
        return null;
      }
    } catch (e) {
      // Handle any errors that occur during the query
      print("Error fetching record: $e");
      return null;
    }
  }

  Future<List<DailyHealthRecord>> getAllRecords(String userId) async {
    // Get a reference to the database
    final db = await initializeDB();

    try {
      // Query the database for records that match the userId
      final List<Map<String, dynamic>> records = await db.query(
        'records',
        where: 'userId = ?',
        whereArgs: [userId],
      );

      // Map the query results to a list of DailyHealthRecord objects
      final allRecords = records.map((record) {
        return DailyHealthRecord.fromMap(record);
      }).toList();

      // Sort the filtered records in ascending order of date
      allRecords.sort((a, b) => a.date.compareTo(b.date));

      return allRecords;
    } catch (e) {
      print('Error fetching records: $e');
      return [];
    }
  }
}
