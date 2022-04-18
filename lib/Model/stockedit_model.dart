class StockEditModel {
  bool? isSuccess;
  String? message;
  String? error;

  StockEditModel({this.isSuccess, this.message, this.error});

  StockEditModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
  }

  factory StockEditModel.withError(String error) => StockEditModel(error: error);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    return data;
  }
}