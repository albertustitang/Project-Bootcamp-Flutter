import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb {
  late Database db;

  Future open() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    //join is from path package
    print(
        path); //output /data/user/0/com.testapp.flutter.testapp/databases/demo.db

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute('''

                    CREATE TABLE IF NOT EXISTS dokumen( 
                          id integer not null primary key autoincrement,
                          dokumen_name varchar(255) not null,
                          nomer_dokumen int not null
                        
                      );
          ''');
          await db.execute(''' 
                     CREATE TABLE IF NOT EXISTS sertifikat( 
                          id integer not null primary key autoincrement,
                          sertifikat_name varchar(255) not null,
                          nomer_sertifikat int not null
                          
                       );
                  
                  ''');
          //table students will be created if there is no table 'students'
          print("Table Created");
        });
  }

  Future<Map<dynamic, dynamic>?> getDokumenById(int id) async {
    List<Map> maps = await db.query('dokumen',
        where: 'id = ?',
        whereArgs: [id]);
    //getting Dokumen data with nomer dokumen.
    if (maps.length > 0) {
      return maps.first;
    }
    return null;
  }
  Future<Map<dynamic, dynamic>?> getSertifikatById(int id) async {
    List<Map> maps = await db.query('sertifikat',
        where: 'id = ?',
        whereArgs: [id]);
    //getting Sertifikat data with nomer sertifikat.
    if (maps.length > 0) {
      return maps.first;
    }
    return null;
  }
}