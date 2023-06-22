import 'package:cpudining/packages/exports.dart';

class AddtoCart {
  String? prdID;
  String? cartsID;
  String? userID;
  String? name;
  double? totalprice;
  int? quantity;
  String? description;
  String? imagelink;
  Timestamp? dateAdded;

  AddtoCart(
      {this.prdID,
      this.cartsID,
      this.userID,
      this.name,
      this.totalprice,
      this.quantity,
      this.description,
      this.imagelink,
      this.dateAdded});

  factory AddtoCart.fromdocument(map) {
    return AddtoCart(
      cartsID: map['cartsID'],
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
      'cartsID': cartsID,
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
