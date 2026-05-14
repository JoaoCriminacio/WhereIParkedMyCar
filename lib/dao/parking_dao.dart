import 'package:where_i_parked_my_car/database/database_provider.dart';
import 'package:where_i_parked_my_car/model/parking.dart';

class ParkingDao {
  final dbProvider = DatabaseProvider.instance;

  Future<void> save(Parking parking) async {
    final db = await dbProvider.database;

    await db.update(
      Parking.TABLE_NAME,
      {Parking.FIELD_IS_ACTIVE: 0},
      where: "${Parking.FIELD_IS_ACTIVE} = 1",
    );

    await db.insert(
      Parking.TABLE_NAME,
      parking.toMap(),
    );
  }

  Future<void> finish(Parking parking) async {
    final db = await dbProvider.database;

    await db.update(
      Parking.TABLE_NAME,
      {Parking.FIELD_IS_ACTIVE: 0},
      where: "${Parking.FIELD_ID} = ?",
      whereArgs: [parking.id]
    );
  }

  Future<Parking?> getLastOne() async {
    final db = await dbProvider.database;
    final results = await db.query(
      Parking.TABLE_NAME,
      columns: [
        Parking.FIELD_ID,
        Parking.FIELD_OBSERVATION,
        Parking.FIELD_DATA,
        Parking.FIELD_LATITUDE,
        Parking.FIELD_LONGITUDE,
        Parking.FIELD_IS_ACTIVE
      ],
      where: "${Parking.FIELD_IS_ACTIVE} = 1",
      orderBy: "${Parking.FIELD_ID} DESC",
      limit: 1,
    );

    if (results.isEmpty) return null;

    return Parking.fromMap(results.first);
  }

  Future<List<Parking>> list() async {
    final db = await dbProvider.database;
    final results = await db.query(
      Parking.TABLE_NAME,
      columns: [
        Parking.FIELD_ID,
        Parking.FIELD_OBSERVATION,
        Parking.FIELD_DATA,
        Parking.FIELD_LATITUDE,
        Parking.FIELD_LONGITUDE,
        Parking.FIELD_IS_ACTIVE
      ],
      where: "${Parking.FIELD_IS_ACTIVE} = 0",
      orderBy: "${Parking.FIELD_ID} DESC"
    );

    return results.map((m) => Parking.fromMap(m)).toList();
  }
}