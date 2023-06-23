import 'package:qr_flutter/qr_flutter.dart';
import '../packages/exports.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  double total = 0;
  bool isclick = false;
  @override
  void initState() {
    checktotal();
    super.initState();
  }

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
            Expanded(
              child: SingleChildScrollView(
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
                              onPressed: () {},
                              icon: const Icon(Icons.pending)),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Card(
                  child: ListTile(
                    leading: QrImageView(
                      data: '${currentuser.uid}',
                      version: QrVersions.auto,
                      size: 80,
                      gapless: false,
                      errorStateBuilder: (cxt, err) {
                        return const Center(
                          child: Text(
                            'Uh oh! Something went wrong...',
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                    trailing: const Icon(
                      Icons.credit_card_rounded,
                      size: 34,
                    ),
                    title: Text(
                      "Php ${total}0",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Order is Preparing "),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Future<double> checktotal() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('checkout')
        .where("userID", isEqualTo: currentuser.uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      List<Map<String, dynamic>> checkoutItems =
          List<Map<String, dynamic>>.from(
              querySnapshot.docs.first.data()['items']);
      double calculateTotal() {
        double total = 0;
        for (Map<String, dynamic> item in checkoutItems) {
          total += item['totalprice'];
        }
        return total;
      }

      double total = calculateTotal();
      setState(() {
        // Update the total in the state variable
        this.total = total;
      });
    }
    return total;
  }
}
