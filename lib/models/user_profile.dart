class UserProfileModel {
  bool? error;
  Data? data;

  UserProfileModel({this.error, this.data});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userID;
  String? countryCode;
  String? emailAddress;
  int? emailverify;
  String? mobileNumber;
  String? name;
  String? status;
  bool? hasPin;
  String? paymentLink;
  TransactionCount? transactionCount;

  Data(
      {this.userID,
      this.countryCode,
      this.emailAddress,
      this.emailverify,
      this.mobileNumber,
      this.name,
      this.status,
      this.hasPin,
      this.paymentLink,
      this.transactionCount});

  Data.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    countryCode = json['countryCode'];
    emailAddress = json['emailAddress'];
    emailverify = json['emailverify'];
    mobileNumber = json['mobileNumber'];
    name = json['name'];
    status = json['status'];
    hasPin = json['hasPin'];
    paymentLink = json['paymentLink'];
    transactionCount = json['transactionCount'] != null
        ? new TransactionCount.fromJson(json['transactionCount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['countryCode'] = this.countryCode;
    data['emailAddress'] = this.emailAddress;
    data['emailverify'] = this.emailverify;
    data['mobileNumber'] = this.mobileNumber;
    data['name'] = this.name;
    data['status'] = this.status;
    data['hasPin'] = this.hasPin;
    data['paymentLink'] = this.paymentLink;
    if (this.transactionCount != null) {
      data['transactionCount'] = this.transactionCount!.toJson();
    }
    return data;
  }
}

class TransactionCount {
  String? currency;
  int? walletBalance;
  int? totalAmount;
  int? totalCount;

  TransactionCount(
      {this.currency, this.walletBalance, this.totalAmount, this.totalCount});

  TransactionCount.fromJson(Map<String, dynamic> json) {
    currency = json['Currency'];
    walletBalance = json['walletBalance'];
    totalAmount = json['totalAmount'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Currency'] = this.currency;
    data['walletBalance'] = this.walletBalance;
    data['totalAmount'] = this.totalAmount;
    data['totalCount'] = this.totalCount;
    return data;
  }
}
