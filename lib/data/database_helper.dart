import 'package:path/path.dart';
import 'package:quiz_defence/models/fame_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class DatabaseHelper {
  static const _databaseName = "Nutrition.db";
  static const _databaseVersion = 1;

  static const table = 'records_v1';

  static const columnId = '_id';
  static const columnYear = 'playground';
  static const columnEpoch = 'epoch';
  static const columnLevel = 'level';

  late Database _db;

  // this opens the database (and creates it if it doesn't exist)
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId TEXT PRIMARY KEY,
            $columnYear INTEGER NOT NULL,
            $columnEpoch INTEGER NOT NULL,
            $columnLevel INTEGER
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(FameModel fame) async {
    Map<String, dynamic> row = {
      columnId: const Uuid().v4(),
      columnEpoch: fame.epoch,
      columnYear: fame.year,
      columnLevel: fame.level,
    };
    return await _db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<FameModel>> queryAllRows(int limit) async {
    var response = await _db.query(table);
    response.map((item) {});
    var data =
        await _db.query(table, orderBy: '$columnYear DESC', limit: limit);
    var result = data.map((element) {
      return FameModel(
          id: 'element[columnId] as String',
          epoch: element[columnEpoch] as int,
          level: element[columnLevel] as int,
          year: element[columnYear] as int);
    }).toList();
    return result;
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<FameModel?> queryRowById(String id) async {
    var response = await _db.query(table);
    response.map((item) {});
    var data = await _db.query(table, where: '$columnId = ?', whereArgs: [id]);
    var result = data.map((element) {
      return FameModel(
          id: element[columnId] as String,
          epoch: element[columnEpoch] as int,
          level: element[columnLevel] as int,
          year: element[columnYear] as int);
    }).toList();
    return result.isEmpty ? null : result[0];
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(FameModel fame) async {
    Map<String, dynamic> row = {
      columnId: fame.id,
      columnYear: fame.year,
      columnEpoch: fame.epoch,
      columnLevel: fame.level,
    };
    return await _db.update(
      table,
      row,
      where: '$columnId = ?',
      whereArgs: [fame.id],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String id) async {
    return await _db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
