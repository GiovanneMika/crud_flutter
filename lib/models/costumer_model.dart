class CostumerModel {
  String? id;
  String? fullName;
  String? email;
  String? phone;
  Address? address;
  bool? isActive;
  double? balance;
  String? lastPurchase;

  CostumerModel({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.address,
    this.isActive,
    this.balance,
    this.lastPurchase,
  });

  CostumerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'] != null
        ? new Address.fromJson(json['address'])
        : null;
    isActive = json['isActive'];
    balance = (json['balance'] as num?)?.toDouble();
    lastPurchase = json['lastPurchase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['isActive'] = this.isActive;
    data['balance'] = this.balance;
    data['lastPurchase'] = this.lastPurchase;
    return data;
  }
}

class Address {
  String? street;
  String? city;
  String? state;
  String? zipCode;

  Address({this.street, this.city, this.state, this.zipCode});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zipCode'] = this.zipCode;
    return data;
  }
}
