import '../../packages/exports.dart';

class CardOrders extends StatelessWidget {
  const CardOrders({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width * 0.90,
        height: 140,
        child: Container(
          padding: const EdgeInsets.only(bottom: 20),
          decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MainText(
                      title: "Total Orders",
                      size: 15,
                      color: Colors.white,
                      fnt: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Orders')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: Text("0"),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: MainText(
                                title: "${snapshot.data!.docs.length}",
                                size: 49,
                                color: Colors.white,
                                fnt: FontWeight.bold,
                              ),
                            );
                          }
                        }),
                  ],
                ),
                Column(
                  children: [
                    const MainText(
                      title: "Add New Product",
                      size: 15,
                      color: Colors.white,
                      fnt: FontWeight.bold,
                    ),
                    const MainText(
                      title: "(Authorized person only)",
                      size: 10,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 10, backgroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const OrdersForm())));
                        },
                        child: const Text("Add Product")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
