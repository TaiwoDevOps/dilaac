class PaymentLinkModel {
  bool? error;
  Data? data;

  PaymentLinkModel({this.error, this.data});

  PaymentLinkModel.fromJson(Map<String, dynamic> json) {
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
  String? url;
  String? reference;

  Data({this.url, this.reference});

  Data.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['reference'] = this.reference;
    return data;
  }
}
