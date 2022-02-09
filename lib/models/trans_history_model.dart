class TransHistoryModel {
  bool? error;
  Data? data;

  TransHistoryModel({this.error, this.data});

  TransHistoryModel.fromJson(Map<String, dynamic> json) {
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
  List<Transactions>? transactions;
  Counter? counter;

  Data({this.transactions, this.counter});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
    counter =
        json['counter'] != null ? new Counter.fromJson(json['counter']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    if (this.counter != null) {
      data['counter'] = this.counter!.toJson();
    }
    return data;
  }
}

class Transactions {
  String? type;
  String? reference;
  int? amount;
  String? currency;
  String? narration;
  String? date;
  String? status;

  Transactions(
      {this.type,
      this.reference,
      this.amount,
      this.currency,
      this.narration,
      this.date,
      this.status});

  Transactions.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    reference = json['reference'];
    amount = json['amount'];
    currency = json['currency'];
    narration = json['narration'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['reference'] = this.reference;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['narration'] = this.narration;
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }
}

class Counter {
  int? amount;
  int? count;

  Counter({this.amount, this.count});

  Counter.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['count'] = this.count;
    return data;
  }
}
