import 'package:cpudining/model/addtocart.dart';
import 'package:cpudining/packages/exports.dart';

class AddCartService {
  final carcolllection = FirebaseFirestore.instance.collection('cart');
  AddtoCart crt = AddtoCart();

  Future<void> addToCart(producid) async {
    try {} catch (error) {
      debugPrint("$error");
    }
  }
}
