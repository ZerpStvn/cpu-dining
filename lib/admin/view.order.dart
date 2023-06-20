import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpudining/admin/home.admin.dart';
import 'package:cpudining/constant/fontstyle.dart';
import 'package:cpudining/model/accept.class.dart';
import 'package:cpudining/model/order.history.dart';
import 'package:cpudining/model/orders.class.dart';
import 'package:flutter/material.dart';

import '../model/id.class.dart';

class ViewOrderAdmin extends StatefulWidget {
  final Orders ord;
  const ViewOrderAdmin({super.key, required this.ord});

  @override
  State<ViewOrderAdmin> createState() => _ViewOrderAdminState();
}

class _ViewOrderAdminState extends State<ViewOrderAdmin> {
  Orders ord = Orders();
  @override
  void initState() {
    getOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ord.userID == null
              ? const Column(
                  children: [
                    SizedBox(
                      height: 230,
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        NetworkImage("${widget.ord.imagelink}"),
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.40),
                                        BlendMode.multiply),
                                    fit: BoxFit.cover)),
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.arrow_back,
                                          color: Colors.white)),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.sort,
                                          color: Colors.white)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    SizedBox(
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MainText(
                                    title: "${widget.ord.name}",
                                    size: 20,
                                    fnt: FontWeight.bold,
                                    color: Colors.black),
                                MainText(
                                  size: 14,
                                  fnt: FontWeight.normal,
                                  color: Colors.grey,
                                  title: "Php ${widget.ord.totalprice}.00",
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const MainText(
                                    title: "Payment Type",
                                    size: 20,
                                    fnt: FontWeight.bold,
                                    color: Colors.black),
                                MainText(
                                  size: 14,
                                  fnt: FontWeight.normal,
                                  color: Colors.grey,
                                  title: "${widget.ord.payementType}",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const MainText(
                                  title: "Total Quantity",
                                  size: 20,
                                  color: Colors.black,
                                  fnt: FontWeight.bold),
                              MainText(
                                  title: "${widget.ord.quantity}",
                                  size: 15,
                                  color: Colors.grey),
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: Colors.grey.withOpacity(0.30),
                          ),
                          const Column(
                            children: [
                              MainText(
                                  title: "Rate",
                                  size: 20,
                                  color: Colors.black,
                                  fnt: FontWeight.bold),
                              MainText(
                                title: "5.0",
                                size: 15,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: Colors.grey.withOpacity(0.30),
                          ),
                          const Column(
                            children: [
                              MainText(
                                  title: "Cooking",
                                  size: 20,
                                  color: Colors.black,
                                  fnt: FontWeight.bold),
                              MainText(
                                title: "5-10 min",
                                size: 15,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MainText(
                              title: "Description",
                              size: 20,
                              color: Colors.black,
                              fnt: FontWeight.bold),
                          MainText(
                            title: "${widget.ord.description}",
                            size: 12,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 10, backgroundColor: Colors.amber),
                          onPressed: () {
                            handleAcceptOrder();
                          },
                          child: const MainText(
                              title: "Accept Order",
                              size: 12,
                              color: Color.fromARGB(255, 20, 15, 15)),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  snackbar(String? title) {
    final snack = SnackBar(content: Text(title!));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  void handleAcceptOrder() async {
    UniqueID uniq = UniqueID();
    AcceptOrd accord = AcceptOrd();
    accord.acceptOrdID = uniq.generateUniqueId();
    accord.ordersID = "${widget.ord.ordersID}";
    accord.userID = "${widget.ord.userID}";
    accord.payementType = "${widget.ord.payementType}";
    accord.onaccept = true;
    accord.prdID = "${widget.ord.prdID}";
    accord.name = "${widget.ord.name}";
    accord.totalprice = double.parse("${widget.ord.totalprice}");
    accord.quantity = int.parse("${widget.ord.quantity}");
    accord.description = "${widget.ord.description}";
    accord.imagelink = "${widget.ord.imagelink}";

    await FirebaseFirestore.instance
        .collection('OrderAccet')
        .doc(uniq.generateUniqueId())
        .set(accord.tomap())
        .then((value) => handleUpdate())
        .then((value) => Navigator.pushAndRemoveUntil(
            context,
            (MaterialPageRoute(builder: (context) => const AdminHomepage())),
            (route) => false));
  }

  void handleUpdate() async {
    OrderHistory ordhst = OrderHistory();
    ordhst.ordersID = "${widget.ord.ordersID}";
    ordhst.userID = "${widget.ord.userID}";
    ordhst.payementType = "${widget.ord.payementType}";
    ordhst.onaccept = true;
    ordhst.prdID = "${widget.ord.prdID}";
    ordhst.name = "${widget.ord.name}";
    ordhst.totalprice = double.parse("${widget.ord.totalprice}");
    ordhst.quantity = int.parse("${widget.ord.quantity}");
    ordhst.description = "${widget.ord.description}";
    ordhst.imagelink = "${widget.ord.imagelink}";
    await FirebaseFirestore.instance
        .collection('Ordershistory')
        .add(ordhst.tomap())
        .then((value) => snackbar("Order Accepted"))
        .then((value) => handledelete());
  }

  void handledelete() async {
    await FirebaseFirestore.instance
        .collection('Orders')
        .doc("${widget.ord.userID}")
        .delete();
  }

  void getOrder() async {
    DocumentSnapshot docs = await FirebaseFirestore.instance
        .collection('Orders')
        .doc("${widget.ord.userID}")
        .get();

    if (docs.exists) {
      setState(() {
        ord = Orders.fromdocument(docs);
      });
    }
  }
}
