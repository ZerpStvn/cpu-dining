import 'package:cpudining/pages/orderView.student.dart';

import '../packages/exports.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.sort),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('checkout')
                    .doc(currentuser.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('No checkout items available.'),
                    );
                  }

                  Map<String, dynamic>? data = snapshot.data?.data();
                  if (data == null || data['items'] == null) {
                    return const Center(
                      child: Text('No checkout items available.'),
                    );
                  }

                  List<Map<String, dynamic>> checkoutItems =
                      List<Map<String, dynamic>>.from(data['items']);
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: checkoutItems.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> item = checkoutItems[index];

                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderViewStudent(
                                      imagelink: item['imagelink'],
                                      name: item['name'],
                                      totalprice: item['totalprice'],
                                      quantity: item['quantity'],
                                      description: item['description'])));
                        },
                        leading: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(item['imagelink']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(item['name'] as String),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Quantity: ${item['quantity']}'),
                            Text('Php ${item['totalprice']}0'),
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              delete(currentuser.uid);
                            },
                            icon: const Icon(Icons.delete)),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void delete(id) async {
    await FirebaseFirestore.instance.collection('checkout').doc(id).delete();
    setState(() {});
  }
}
