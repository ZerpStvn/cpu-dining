import 'package:cpudining/components/component/Listview.order.user.dart';
import 'package:cpudining/packages/exports.dart';

import '../../model/orders.class.dart';

class OrdersAdmin extends StatefulWidget {
  const OrdersAdmin({super.key});

  @override
  State<OrdersAdmin> createState() => _OrdersAdminState();
}

class _OrdersAdminState extends State<OrdersAdmin> {
  List order = [];

  @override
  void initState() {
    getorders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          getorders();
                        });
                      },
                      icon: const Icon(Icons.refresh)),
                  const Text("Refresh"),
                ],
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: order.length,
              itemBuilder: ((context, index) {
                return OrderCompnentView(
                  ord: order[index] as Orders,
                );
              })),
        ),
      ],
    );
  }

  Future getorders() async {
    final data = await FirebaseFirestore.instance.collection('Orders').get();

    if (mounted) {
      setState(() {
        order = List.from(data.docs.map((doc) => Orders.fromdocument(doc)));
      });
    } else {
      dispose();
    }
  }
}
