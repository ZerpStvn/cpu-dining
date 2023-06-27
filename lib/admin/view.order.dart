import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../constant/fontstyle.dart';

class ViewOrderAdmin extends StatefulWidget {
  final String userid;
  const ViewOrderAdmin({
    super.key,
    required this.userid,
  });

  @override
  State<ViewOrderAdmin> createState() => _ViewOrderAdminState();
}

class _ViewOrderAdminState extends State<ViewOrderAdmin> {
  String uniqID = const Uuid().v4();
  double total = 0;
  String? name;
  String? userID;
  List<Map<String, dynamic>> checkout = [];

  @override
  void initState() {
    getdata();
    getOrders();
    super.initState();
  }

  Future<void> getdata() async {
    final data = await FirebaseFirestore.instance
        .collection('checkout')
        .doc(widget.userid)
        .get();

    List<Map<String, dynamic>> checkoutItems =
        List<Map<String, dynamic>>.from(data['items']);
    if (data.exists) {
      if (checkoutItems.isNotEmpty) {
        double caltotal = 0;

        for (var item in checkoutItems) {
          double totalPrice = item['totalprice'] as double;
          caltotal += totalPrice;
        }

        setState(() {
          total = caltotal;
        });
      }
    } else {
      return snackbar("no data");
    }
  }

  Future<void> getOrders() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('checkout').get();

    if (mounted) {
      setState(() {
        List<Map<String, dynamic>> data =
            querySnapshot.docs.map((doc) => doc.data()).toList();

        if (data.isNotEmpty) {
          name = data[0]['name'];
          userID = data[0]['school ID'] ?? "no ID";
        } else {
          name = null;
        }
        checkout = data;
      });
    }
  }

  Future<void> storeDataToOrderDelivered(
      List<Map<String, dynamic>> data) async {
    final CollectionReference orderDeliveredCollection =
        FirebaseFirestore.instance.collection('orderDelivered');

    for (var item in data) {
      await orderDeliveredCollection
          .doc(uniqID)
          .set(item)
          .then((value) => orderhistory(data));
    }
  }

  void delete() async {
    await FirebaseFirestore.instance
        .collection('checkout')
        .doc(widget.userid)
        .delete()
        .then((value) => Navigator.pop(context));
  }

  Future<void> orderhistory(List<Map<String, dynamic>> data) async {
    final CollectionReference orderDeliveredCollection =
        FirebaseFirestore.instance.collection('ordersave');

    for (var item in data) {
      await orderDeliveredCollection
          .add(item)
          .then((value) => delete())
          .then((value) => snackbar("Item delivered to the customer"));
    }
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
            const SizedBox(
              height: 20,
            ),
            ListTile(
              trailing: const Icon(
                Icons.check_circle_outline,
                color: Colors.amber,
              ),
              leading: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/profile.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text("$name",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              subtitle: Text("$userID"),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('checkout')
                      .doc(widget.userid)
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
                          subtitle: Text('Quantity: ${item['quantity']}'),
                          trailing: Text('Php ${item['totalprice']}0'),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        title: Text(
                          "Total Php ${total}0",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(Icons.check_circle_outline),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          backgroundColor: Colors.amber,
                        ),
                        onPressed: () {
                          storeDataToOrderDelivered(checkout);
                        },
                        child: const MainText(
                          title: "Deliver",
                          size: 12,
                          color: Color.fromARGB(255, 20, 15, 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  snackbar(String? title) {
    final snack = SnackBar(content: Text(title!));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
