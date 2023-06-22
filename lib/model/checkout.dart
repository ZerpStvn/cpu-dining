import '../packages/exports.dart';

class CheckedOut {
  String? prdID;
  String? ordersID;
  String? userID;
  String? name;
  double? totalprice;
  int? quantity;
  String? description;
  String? imagelink;
  Timestamp? dateAdded;

  CheckedOut(
      {this.prdID,
      this.ordersID,
      this.userID,
      this.name,
      this.totalprice,
      this.quantity,
      this.description,
      this.imagelink,
      this.dateAdded});

  factory CheckedOut.fromdocument(map) {
    return CheckedOut(
      ordersID: map['ordersID'],
      userID: map['userID'],
      prdID: map['prdID'],
      name: map['name'],
      totalprice: map['totalprice'],
      quantity: map['quantity'],
      description: map['description'],
      imagelink: map['imagelink'],
      dateAdded: map['dateAdded'],
    );
  }
  Map<String, dynamic> tomap() {
    return {
      'ordersID': ordersID,
      'userID': userID,
      'prdID': prdID,
      'name': name,
      'totalprice': totalprice,
      'quantity': quantity,
      'description': description,
      'imagelink': imagelink,
      'dateAdded': DateTime.now(),
    };
  }
}
