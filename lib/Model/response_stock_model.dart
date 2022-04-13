class StockModel {
  bool? isSuccess;
  String? message;

  String? error;

  StockModel({this.isSuccess, this.message, this.error});

  StockModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    }
  factory StockModel.withError(String error) => StockModel(error: error);
}