import 'package:cpudining/packages/exports.dart';

import '../component/Listview.order.user.dart';

class OrdersAdmin extends StatefulWidget {
  const OrdersAdmin({Key? key}) : super(key: key);

  @override
  State<OrdersAdmin> createState() => _OrdersAdminState();
}

class _OrdersAdminState extends State<OrdersAdmin> {
  List<Map<String, dynamic>> checkout = [];

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: checkout.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> orderData = checkout[index];
              return OrderCompnentView(
                name: orderData['name'] ?? '',
                total: orderData['total'] ?? 0.0,
                schoolID: orderData['school ID'] ?? '',
                userid: orderData['userID'] ?? '',
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> getOrders() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('checkout').get();

    if (mounted) {
      setState(() {
        checkout = querySnapshot.docs.map((doc) => doc.data()).toList();
      });
    }
  }
}
