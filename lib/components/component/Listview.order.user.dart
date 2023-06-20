import 'package:cpudining/admin/view.order.dart';
import 'package:cpudining/model/orders.class.dart';
import 'package:cpudining/pages/orderView.student.dart';

import '../../packages/exports.dart';

class OrderCompnentView extends StatefulWidget {
  final Orders ord;
  const OrderCompnentView({super.key, required this.ord});

  @override
  State<OrderCompnentView> createState() => _OrderCompnentViewState();
}

class _OrderCompnentViewState extends State<OrderCompnentView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Card(
        color: const Color.fromARGB(255, 255, 255, 255),
        elevation: 5,
        child: ListTile(
          onTap: () {
            if (currentuser.userrole == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewOrderAdmin(
                            ord: widget.ord,
                          )));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderViewStudent(
                            ord: widget.ord,
                          )));
            }
          },
          contentPadding: const EdgeInsets.all(10),
          leading: Container(
            height: 90,
            width: 110,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("${widget.ord.imagelink}"),
                    fit: BoxFit.cover)),
          ),
          title: Text("${widget.ord.name}"),
          subtitle: MainText(
              title: "Php ${widget.ord.totalprice}0",
              size: 10,
              color: Colors.grey),
          trailing: const Icon(Icons.receipt),
        ),
      ),
    );
  }
}
