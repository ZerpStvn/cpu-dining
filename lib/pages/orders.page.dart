import 'package:cpudining/model/orders.class.dart';

import '../components/component/Listview.order.user.dart';
import '../packages/exports.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List orders = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: ((context) => const Homepge())),
                  (route) => false);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MainText(
                      title: "Your Orders ", size: 12, color: Colors.black),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              onRefreshitem();
                            });
                          },
                          icon: const Icon(Icons.refresh)),
                      const MainText(
                          title: "Refresh ", size: 12, color: Colors.black),
                    ],
                  ),
                ],
              ),
              FutureBuilder(
                  future: FirebaseFirestore.instance.collection('Orders').get(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      return const Center(
                        child: Text("Loadding"),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            Orders ords = Orders.fromdocument(
                                snapshot.data!.docs[index].data());
                            if (currentuser.uid == ords.userID) {
                              return OrderCompnentView(
                                ord: ords,
                              );
                            } else {
                              return null;
                            }
                          }));
                    }
                    return Container();
                  })),
            ],
          ),
        ),
      ),
    );
  }

  Future onRefreshitem() async {
    final data = await FirebaseFirestore.instance.collection('Orders').get();

    if (mounted) {
      setState(() {
        orders = List.from(data.docs.map((doc) => Orders.fromdocument(doc)));
      });
    } else {
      dispose();
    }
  }
}
