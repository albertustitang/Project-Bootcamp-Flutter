import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taniku/Model/response_addkebun_model.dart';
import 'package:taniku/Model/response_jenisdokumen_model.dart';
import 'package:taniku/Model/response_listsertifikat_model.dart';

import '../../Model/response_tambahdokumen_model.dart';
import '../../Model/response_tambahsertifikasi_model.dart';

class MyDb{
  late Database db;

  Future open() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String? path = join(databasesPath, 'taniku.db');
    //join is from path package
    print(path); //output /data/user/0/com.testapp.flutter.testapp/databases/demo.db

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute('''

                    CREATE TABLE IF NOT EXISTS dokumen( 
                          id integer not null primary key autoincrement,
                          dokumen_name varchar(255) not null,
                          nomor_dokumen varchar(255) not null,
                          foto_dokumen varchar(500) not null
                      );
                      //create more table here
                  ''');
          await db.execute('''

                    CREATE TABLE IF NOT EXISTS sertifikasi( 
                          id integer not null primary key autoincrement,
                          sertifikat_name varchar(255) not null,
                          nomer_sertifikat varchar(255) not null,
                          tanggal_berlaku varchar(255) not null,
                          tanggal_berakhir varchar(255) not null,
                          foto_sertif varchar(500) not null
                      );
                      //create more table here
                  ''');
          //table students will be created if there is no table 'students'
          print("Table Created");
        });
  }

  Future<List<ListTambahDokumen>> getListDokumen(BuildContext context) async {
    final List<Map<String, dynamic>> data = await db.rawQuery('SELECT * FROM dokumen');
    print(data);
    if (data.isNotEmpty) {
      return List.generate(data.length, (i) {
        return ListTambahDokumen(
          id: data[i]['id'],
          nama_dokumen: data[i]['dokumen_name'],
          no_dokumen: data[i]['nomor_dokumen'],
          foto: data[i]['foto_dokumen'],
        );
      });
    }
    return [];
  }

  Future<List<ListDokumen>> convertListDokumen() async {
    final List<Map<String, dynamic>> result = await db.query('dokumen', orderBy: 'id');
    if(result.isNotEmpty) {
      return List.generate(result.length, (index){
        return ListDokumen(
          dokumenId: result[index]['dokumen_name'],
          nomor: result[index]['nomor_dokumen'],
          foto: result[index]['foto_dokumen']
        );
      });
    }
    return[];
  }

  Future<ListTambahDokumen?> getDokumenById(int id, BuildContext context) async {
    List<Map> maps = await db.query('dokumen',
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return ListTambahDokumen(
        id: maps[0]['id'],
        nama_dokumen: maps[0]['dokumen_name'],
        no_dokumen: maps[0]['nomor_dokumen'],
        foto: maps[0]['foto_dokumen'],
      );
    }
    print(maps);
    return null;
  }

  addDokumen(String namaDokumen, String noDokumen, String image, BuildContext context) async {
    await db.rawInsert("INSERT INTO dokumen(dokumen_name, nomor_dokumen, foto_dokumen) VALUES (?, ?, ?);",
        [namaDokumen, noDokumen, image]);
  }
  editDokumen(int id, String namaDokumen, String noDokumen, String image, BuildContext context) async {
    await db.rawInsert("UPDATE dokumen SET dokumen_name = ?, nomor_dokumen = ?, foto_dokumen = ? WHERE id = ?",
        [namaDokumen, noDokumen, image.toString(), id]);
  }
  deleteDokumen(int id, BuildContext context) async {
    await db.rawDelete("DELETE FROM dokumen WHERE id = ?", [id]);
  }

  Future<List<ListTambahSertif>> getListSetif(BuildContext context) async {
    final List<Map<String, dynamic>> data = await db.rawQuery('SELECT * FROM sertifikasi');
    print(data);
    if (data.isNotEmpty) {
      return List.generate(data.length, (i) {
        return ListTambahSertif(
          id: data[i]['id'],
          nama_sertif: data[i]['sertifikat_name'],
          no_sertif: data[i]['nomer_sertifikat'],
          tanggal_berlaku: data[i]['tanggal_berlaku'],
          tanggal_berakhir: data[i]['tanggal_berakhir'],
          foto: data[i]['foto_sertif'],
        );
      });
    }
    return [];
  }

  Future<List<ListSertifikasi>> convertListSertifikat() async {
    final List<Map<String, dynamic>> result = await db.query('sertifikasi', orderBy: 'id');
    if(result.isNotEmpty) {
      return List.generate(result.length, (index){
        return ListSertifikasi(
            sertifikasiNo: result[index]['sertifikat_name'],
            sertifikasiDari: result[index]['tanggal_berlaku'],
            sertifikasiSampai: result[index]['tanggal_berakhir'],
            sertifikasiImage: result[index]['foto_sertif']
        );
      });
    }
    return[];
  }

  Future<ListTambahSertif?> getSertifById(int id, BuildContext context) async {
    List<Map> maps = await db.query('sertifikasi',
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return ListTambahSertif(
        id: maps[0]['id'],
        nama_sertif: maps[0]['sertifikat_name'],
        no_sertif: maps[0]['nomer_sertifikat'],
        tanggal_berlaku: maps[0]['tanggal_berlaku'],
        tanggal_berakhir: maps[0]['tanggal_berakhir'],
        foto: maps[0]['foto_sertif'],
      );
    }
    return null;
  }

  addSertif(String namaSertif, String noSertif, String dateController, String dateController2, String image, BuildContext context) async {
    await db.rawInsert("INSERT INTO sertifikasi(sertifikat_name, nomer_sertifikat, tanggal_berlaku, tanggal_berakhir, foto_sertif) VALUES (?, ?, ?, ?, ?);",
        [namaSertif, noSertif, dateController, dateController2, image]);
  }
  editSertif(int id, String namaSertif, String noSertif, String dateController, String dateController2, String image, BuildContext context) async {
    await db.rawInsert("UPDATE sertifikasi SET sertifikat_name = ?, nomer_sertifikat = ?, tanggal_berlaku = ?, tanggal_berakhir = ?, foto_sertif = ? WHERE id = ?",
        [namaSertif, noSertif, dateController, dateController2, image.toString(), id]);
  }
  deleteSertif(int id, BuildContext context) async {
    await db.rawDelete("DELETE FROM sertifikasi WHERE id = ?", [id]);
  }
}