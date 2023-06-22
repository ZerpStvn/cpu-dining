import '../../admin/view.order.dart';
import '../../packages/exports.dart';

class OrderCompnentView extends StatefulWidget {
  final String name;
  final double total;
  final String schoolID;
  final String userid;
  const OrderCompnentView({
    super.key,
    required this.name,
    required this.total,
    required this.schoolID,
    required this.userid,
  });

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
                            userid: widget.userid,
                          )));
            }
          },
          contentPadding: const EdgeInsets.all(10),
          leading: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/order.png'), fit: BoxFit.cover)),
          ),
          title: Text(widget.name),
          subtitle: MainText(
              title: "Php ${widget.total}0", size: 10, color: Colors.grey),
          trailing: const Icon(Icons.receipt),
        ),
      ),
    );
  }
}
