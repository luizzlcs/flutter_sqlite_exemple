import 'package:flutter/material.dart';
import 'package:flutter_sqlite_exemple/database/database_sqlite.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _database();
  }

  Future<void> _database() async {
    final database = await DatabaseSqlite().openConnection();

    // database.insert('teste', {'nome': 'Thiago Pereira'});
    // database.delete('teste', where: 'id = ?', whereArgs: [3]);
    // database.update('teste', {'nome': 'Lucicleide Oliveira Silva'},
    //     where: 'id = ?', whereArgs: [6]);
    // var result = await database.query('teste');
    // print(result);

// duas formas de acesar os dados:

    // database.rawInsert('insert into teste values (null, ?)', ['Maria Lucia']);
    // database.rawUpdate('update teste set nome = ? where  id = ?',  ['Luiz Carlos da Silva', 5]);
    // database.rawDelete('delete from teste where id = ?',  [10]);
    var result = await database.rawQuery('select * from teste');
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sqlite com Flutter',
              style: TextStyle(
                fontSize: 42,
                color: Colors.deepOrange[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image.network(
                'https://media.gettyimages.com/vectors/database-line-icon-vector-id1305254891?s=2048x2048',
                width: 80,
                height: 80,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
