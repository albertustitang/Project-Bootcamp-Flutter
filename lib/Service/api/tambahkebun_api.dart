import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taniku/Model/response_jenisbibit_model.dart';
import 'package:taniku/Model/response_jenisdokumen_model.dart';
import 'package:taniku/Model/response_kabupaten_model.dart';
import 'package:taniku/Model/response_kecamatan_model.dart';
import 'package:taniku/Model/response_kelurahan%20_model.dart';
import 'package:taniku/Model/response_sertifikasi_model.dart';
import 'package:taniku/Model/response_tipelahan_model.dart';
import 'package:taniku/Service/local/shared_pref_service.dart';

import 'package:taniku/Model/response_provinsi_model.dart';

class TambahkebunApi {
  var client = http.Client();
  var baseUrl = "http://34.126.79.39:81/";

  Future<ProvinsiModel> getListProvinsi(BuildContext context) async {
    var uri = Uri.parse(baseUrl + "api/niaga/wilayah/provinsi").replace();
    final tokenLocal = await SharedPreferenceService().getStringSharedPref("token");
    // final petaniIdLocal = await SharedPreferenceService().getStringSharedPref("petani_id");
    // final userIdLocal = await SharedPreferenceService().getStringSharedPref("user_id");
    Map<String, String> headersToken(String token) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    }
    var _body = jsonEncode({});
    try {
      final response = await client
          .post(uri, headers: headersToken(tokenLocal), body: _body)
          .timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return ProvinsiModel.fromJson(jsonDecode(response.body));
      } else {
        return ProvinsiModel.withError("Gagal Load Data");
      }
    } on TimeoutException catch (_) {
      return ProvinsiModel.withError("Waktu Habis, Silahkan Coba Kembali");
    }
  }

  Future<KabupatenModel> getListKabupaten(String provinsiId, BuildContext context) async {
    var uri = Uri.parse(baseUrl + "api/niaga/wilayah/kabupatenKota").replace();
    final tokenLocal = await SharedPreferenceService().getStringSharedPref("token");
    Map<String, String> headersToken(String token) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    }
    var _body = jsonEncode({
      "provinsi_id": provinsiId,

    });
    try {
      final response = await client
          .post(uri, headers: headersToken(tokenLocal), body: _body)
          .timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return KabupatenModel.fromJson(jsonDecode(response.body));
      } else {
        return KabupatenModel.withError("Gagal Load Data");
      }
    } on TimeoutException catch (_) {
      return KabupatenModel.withError("Waktu Habis, Silahkan Coba Kembali");
    }
  }

  Future<KecamatanModel> getListKecamatan(String kabupatenkotaId, BuildContext context) async {
    var uri = Uri.parse(baseUrl + "api/niaga/wilayah/kecamatan").replace();
    final tokenLocal = await SharedPreferenceService().getStringSharedPref("token");
    Map<String, String> headersToken(String token) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    }
    var _body = jsonEncode({
      "kabupaten_kota_id": kabupatenkotaId,

    });
    try {
      final response = await client
          .post(uri, headers: headersToken(tokenLocal), body: _body)
          .timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return KecamatanModel.fromJson(jsonDecode(response.body));
      } else {
        return KecamatanModel.withError("Gagal Load Data");
      }
    } on TimeoutException catch (_) {
      return KecamatanModel.withError("Waktu Habis, Silahkan Coba Kembali");
    }
  }

  Future<KelurahanModel> getListKelurahan(String kecamatanId, BuildContext context) async {
    var uri = Uri.parse(baseUrl + "api/niaga/wilayah/kelurahanDesa").replace();
    final tokenLocal = await SharedPreferenceService().getStringSharedPref("token");
    Map<String, String> headersToken(String token) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    }
    var _body = jsonEncode({

      "kecamatan_id": kecamatanId,

    });
    try {
      final response = await client
          .post(uri, headers: headersToken(tokenLocal), body: _body)
          .timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return KelurahanModel.fromJson(jsonDecode(response.body));
      } else {
        return KelurahanModel.withError("Gagal Load Data");
      }
    } on TimeoutException catch (_) {
      return KelurahanModel.withError("Waktu Habis, Silahkan Coba Kembali");
    }
  }

  Future<JenisBibitModel> getListJenisBibit(BuildContext context) async {
    var uri = Uri.parse(baseUrl + "api/niaga/listJenisBibit").replace();
    final tokenLocal = await SharedPreferenceService().getStringSharedPref("token");
    // final petaniIdLocal = await SharedPreferenceService().getStringSharedPref("petani_id");
    // final userIdLocal = await SharedPreferenceService().getStringSharedPref("user_id");
    Map<String, String> headersToken(String token) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    }
    var _body = jsonEncode({});
    try {
      final response = await client
          .get(uri, headers: headersToken(tokenLocal))
          .timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return JenisBibitModel.fromJson(jsonDecode(response.body));
      } else {
        return JenisBibitModel.withError("Gagal Load Data");
      }
    } on TimeoutException catch (_) {
      return JenisBibitModel.withError("Waktu Habis, Silahkan Coba Kembali");
    }
  }

  Future<TipeLahanModel> getListTipeLahan(BuildContext context) async {
    var uri = Uri.parse(baseUrl + "api/niaga/listStatusLahan").replace();
    final tokenLocal = await SharedPreferenceService().getStringSharedPref("token");
    Map<String, String> headersToken(String token) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    }
    var _body = jsonEncode({});
    try {
      final response = await client
          .get(uri, headers: headersToken(tokenLocal))
          .timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return TipeLahanModel.fromJson(jsonDecode(response.body));
      } else {
        return TipeLahanModel.withError("Gagal Load Data");
      }
    } on TimeoutException catch (_) {
      return TipeLahanModel.withError("Waktu Habis, Silahkan Coba Kembali");
    }
  }

  Future<JenisDokumenModel> getListDokumen(BuildContext context) async {
    var uri = Uri.parse(baseUrl + "api/niaga/listJenisDokumen").replace();
    final tokenLocal = await SharedPreferenceService().getStringSharedPref("token");
    Map<String, String> headersToken(String token) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    }
    var _body = jsonEncode({});
    try {
      final response = await client
          .get(uri, headers: headersToken(tokenLocal))
          .timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return JenisDokumenModel.fromJson(jsonDecode(response.body));
      } else {
        return JenisDokumenModel.withError("Gagal Load Data");
      }
    } on TimeoutException catch (_) {
      return JenisDokumenModel.withError("Waktu Habis, Silahkan Coba Kembali");
    }
  }

  Future<SertifikasiModel> getListSertifikasi(BuildContext context) async {
    var uri = Uri.parse(baseUrl + "api/niaga/listSertifikasi").replace();
    final tokenLocal = await SharedPreferenceService().getStringSharedPref("token");
    Map<String, String> headersToken(String token) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    }
    var _body = jsonEncode({});
    try {
      final response = await client
          .get(uri, headers: headersToken(tokenLocal))
          .timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return SertifikasiModel.fromJson(jsonDecode(response.body));
      } else {
        return SertifikasiModel.withError("Gagal Load Data");
      }
    } on TimeoutException catch (_) {
      return SertifikasiModel.withError("Waktu Habis, Silahkan Coba Kembali");
    }
  }




}





