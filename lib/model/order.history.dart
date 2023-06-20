class OrderHistory {
  String? prdID;
  String? ordersID;
  String? userID;
  String? name;
  double? totalprice;
  int? quantity;
  String? description;
  String? payementType;
  String? imagelink;
  bool? onaccept;

  OrderHistory(
      {this.onaccept,
      this.prdID,
      this.ordersID,
      this.userID,
      this.payementType,
      this.name,
      this.totalprice,
      this.quantity,
      this.description,
      this.imagelink});

  factory OrderHistory.fromdocument(map) {
    return OrderHistory(
      ordersID: map['ordersID'],
      userID: map['userID'],
      payementType: map['payementType'],
      onaccept: map['onaccept'],
      prdID: map['prdID'],
      name: map['name'],
      totalprice: map['totalprice'],
      quantity: map['quantity'],
      description: map['description'],
      imagelink: map['imagelink'],
    );
  }
  Map<String, dynamic> tomap() {
    return {
      'ordersID': ordersID,
      'userID': userID,
      'payementType': payementType,
      'onaccept': onaccept,
      'prdID': prdID,
      'name': name,
      'totalprice': totalprice,
      'quantity': quantity,
      'description': description,
      'imagelink': imagelink,
    };
  }
}
