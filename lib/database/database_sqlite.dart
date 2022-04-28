import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseSqlite {
  Future<Database> openConnection() async {
    final databasePath = await getDatabasesPath();
    final databaseFinalPath = join(databasePath, 'SQLITE_EXEMPLE');

    return await openDatabase(
      databaseFinalPath,
      version: 1,
      onConfigure: (db) async {
          print('Onconfigure sendo chamado');
        await db.execute('PRAGMA foreign_keys = ON');
      },
      // Chamado somente no momento de criação do banco de dados
      // primeira vez que carrega o aplicativo.
      onCreate: (Database db, int version) {
        print('OnCreate chamado');

        final batch = db.batch();

        batch.execute('''
        create table teste(
          id Integer primary key autoincrement,
          nome varchar(200)
        )
      ''');

        batch.execute('''
        create table produto(
          id Integer primary key autoincrement,
          nome varchar(200)
        )
      ''');

        /* batch.execute('''
        create table categoria(
          id Integer primary key autoincrement,
          nome varchar(200)
        )
      '''); */
        batch.commit();
      },

      // Será chamdo sempre que ouver uma alteração no version incremental (1 -> 2)
      onUpgrade: (Database db, int oldVersion, int version) {
        print('OnUpgrade chamado');

        final batch = db.batch();

        if (oldVersion == 1) {
          batch.execute('''
        create table produto(
          id Integer primary key autoincrement,
          nome varchar(200)
        )
      ''');

          /* batch.execute('''
        create table categoria(
          id Integer primary key autoincrement,
          nome varchar(200)
        )
      '''); */

          /*   if (oldVersion == 2) {
            batch.execute('''
        create table categoria(
          id Integer primary key autoincrement,
          nome varchar(200)
        )
      ''');

          } */
          batch.commit();
        }
      },

      // Será chamdo sempre que ouver uma alteração no version decremental (2 -> 1)
      onDowngrade: (Database db, int oldVersion, int version) {
        print('OnDowgrade chamado');

        final batch = db.batch();

        if (oldVersion == 3) {
          batch.execute('''
        drop table categoria
        ''');
        }
        batch.commit();
      },
    );
  }
}
