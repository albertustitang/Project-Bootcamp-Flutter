class SertifikasiModel {
  bool? isSuccess;
  String? message;
  List<DataSertifikat>? data;
  String? error;

  SertifikasiModel({this.isSuccess, this.message, this.data, this.error});

  SertifikasiModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataSertifikat>[];
      json['data'].forEach((v) {
        data!.add(new DataSertifikat.fromJson(v));
      });
    }
  }
  factory SertifikasiModel.withError(String error) => SertifikasiModel(error: error);


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataSertifikat {
  int? sertifikasiId;
  String? sertifikasiName;

  DataSertifikat({this.sertifikasiId, this.sertifikasiName});

  DataSertifikat.fromJson(Map<String, dynamic> json) {
    sertifikasiId = json['sertifikasi_id'];
    sertifikasiName = json['sertifikasi_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sertifikasi_id'] = this.sertifikasiId;
    data['sertifikasi_name'] = this.sertifikasiName;
    return data;
  }
}