class CostumerModel {
  String? id;
  String? fullName;
  String? email;
  String? phone;
  Address? address;
  bool? isActive;
  double? balance;
  String? lastPurchase;
  String? password;
  String? profileImageUrl;

  CostumerModel({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.address,
    this.isActive,
    this.balance,
    this.lastPurchase,
    this.password,
    this.profileImageUrl,
  });

  CostumerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'] != null
        ? Address.fromJson(json['address'])
        : null;
    isActive = json['isActive'];
    balance = (json['balance'] as num?)?.toDouble();
    lastPurchase = json['lastPurchase'];
    password = json['password'];
    profileImageUrl = json['profileImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    data['fullName'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['isActive'] = isActive;
    data['balance'] = balance;
    data['lastPurchase'] = lastPurchase;
    data['password'] = password;
    data['profileImageUrl'] = profileImageUrl;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['city'] = city;
    data['state'] = state;
    data['zipCode'] = zipCode;
    return data;
  }
}
