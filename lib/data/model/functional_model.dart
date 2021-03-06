class FunctionalModel {
  String error;
  String errorMessage;
  String status;

  FunctionalModel({this.error, this.errorMessage, this.status});

  FunctionalModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    errorMessage = json['error_message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['error_message'] = this.errorMessage;
    data['status'] = this.status;
    return data;
  }
}