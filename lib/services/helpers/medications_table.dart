import 'package:diabuddy/models/medication_intake_model.dart';
import 'package:sqflite/sqflite.dart';

class MedicationsTable {
  static const tableName = "medications";
  static const columnMedicationId = "medicationId";
  static const columnUserId = "userId";
  static const columnChannelId = "channelId";
  static const columnName = "name";
  static const columnTime = "time";
  static const columnDose = "dose";
  static const columnFrequency = "frequency";
  static const columnVerifiedBy = "verifiedBy";
  static const columnIsActive = "isActive";

  static Future<void> createTable(Database db) async {
    print("creating medications tables ===========================");

    try {
      await db.execute('''
      CREATE TABLE $tableName (
        $columnMedicationId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnUserId TEXT NOT NULL,
        $columnChannelId INTEGER NOT NULL,
        $columnName TEXT NOT NULL,
        $columnTime TEXT NOT NULL,
        $columnDose TEXT NOT NULL,
        $columnFrequency TEXT NOT NULL,
        $columnVerifiedBy TEXT NOT NULL,
        $columnIsActive INTEGER NOT NULL
      )
    ''');
      print('$tableName table created successfully.');
    } catch (e) {
      print('Error creating $tableName table: $e');
    }
  }

  static Future<int> insertMedication(Database db, MedicationIntake medicationIntake) async {
    try {
      print('Attempting to insert medication');
      final id = await db.insert(
        tableName,
        medicationIntake.toJson(medicationIntake),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Insert successful, new row ID: $id');
      return id;
    } catch (e) {
      print('Error inserting medication: $e');
      rethrow;
    }
  }
}
