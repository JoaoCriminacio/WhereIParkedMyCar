import 'package:sqflite/sqflite.dart';
import 'package:where_i_parked_my_car/model/parking.dart';

class DatabaseProvider {
  static const _dbName = 'parked_car.db';
  static const _dbVersion = 1;

  DatabaseProvider.int();

  static final DatabaseProvider instance = DatabaseProvider.int();

  Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }

    return _database!;
  }

  Future<Database> _initDatabase() async {
    String databasePath = await getDatabasesPath();
    String dbPath = '$databasePath/$_dbName';
    return await openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE ${Parking.TABLE_NAME} (
        ${Parking.FIELD_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Parking.FIELD_OBSERVATION} TEXT NOT NULL,
        ${Parking.FIELD_DATA} TEXT NOT NULL,
        ${Parking.FIELD_LATITUDE} REAL NOT NULL,
        ${Parking.FIELD_LONGITUDE} REAL NOT NULL,
        ${Parking.FIELD_PHOTO_PATH} TEXT,
        ${Parking.FIELD_IS_ACTIVE} INTEGER NOT NULL
      );
      '''
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {

  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
    }
  }
}