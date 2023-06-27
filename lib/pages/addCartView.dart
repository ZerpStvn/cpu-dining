import 'package:cpudining/model/addtocart.dart';
import 'package:cpudining/model/orders.class.dart';
import 'package:cpudining/packages/exports.dart';

import '../components/controller/qr.order.dart';

class AddToCartView extends StatefulWidget {
  const AddToCartView({Key? key}) : super(key: key);

  @override
  State<AddToCartView> createState() => _AddToCartViewState();
}

class _AddToCartViewState extends State<AddToCartView> {
  double total = 0;
  bool ischeckedout = false;
  bool ischecked = false;
  bool isloading = false;
  String? paytype;

  @override
  void initState() {
    calculateTotal();
    super.initState();
  }

  Future<void> calculateTotal() async {
    await Future.delayed(Duration.zero); // Delay to allow build to complete
    double calculatedTotal = 0;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('cart')
        .where('userID', isEqualTo: currentuser.uid)
        .get();

    if (snapshot.docs.isNotEmpty) {
      List<AddtoCart> cartItems = snapshot.docs
          .map((doc) => AddtoCart.fromdocument(doc.data()))
          .toList();

      for (var item in cartItems) {
        calculatedTotal += item.totalprice!;
      }
    }

    setState(() {
      total = calculatedTotal;
    });
  }

  snackbar(String? title) {
    final snack = SnackBar(content: Text(title!));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  @override
  Widget build(BuildContext context) {
    return ischeckedout
        ? Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    setState(() {
                      ischeckedout = false;
                    });
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            body: Column(
              children: [
                const MainText(
                    title: "Choose payement option",
                    size: 14,
                    color: Colors.black),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: const MainText(
                      title: "Gcash", size: 14, color: Colors.black),
                  subtitle: const MainText(
                      title: "Coming soon", size: 10, color: Colors.grey),
                  leading: SizedBox(
                    width: 30,
                    height: 30,
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/GCash_Logo.png"),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.20),
                  thickness: 1,
                ),
                ListTile(
                  title: const MainText(
                      title: "Debit/Credit Card",
                      size: 14,
                      color: Colors.black),
                  subtitle: const MainText(
                      title: "Coming soon", size: 10, color: Colors.grey),
                  leading: SizedBox(
                    width: 50,
                    height: 30,
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/pngwing.com.png"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.20),
                  thickness: 1,
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      paytype = "Over the Counter";
                    });
                  },
                  title: const MainText(
                      title: "Over the Counter", size: 14, color: Colors.black),
                  subtitle: const MainText(
                      title: "Available", size: 10, color: Colors.grey),
                  leading: const Icon(
                    Icons.credit_card_rounded,
                    size: 34,
                  ),
                  trailing: paytype == "Over the Counter"
                      ? const Icon(
                          Icons.check_circle_outline_rounded,
                          color: Colors.green,
                          size: 13,
                        )
                      : const Text(""),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      paytype = "CPU E-wallet";
                    });
                  },
                  title: const MainText(
                      title: "CPU E-wallet", size: 14, color: Colors.black),
                  subtitle: const MainText(
                      title: "Available", size: 10, color: Colors.grey),
                  leading: const Icon(
                    Icons.credit_card_rounded,
                    size: 34,
                  ),
                  trailing: paytype == "CPU E-wallet"
                      ? const Icon(
                          Icons.check_circle_outline_rounded,
                          color: Colors.green,
                          size: 13,
                        )
                      : const Text(""),
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.50,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 10, backgroundColor: Colors.amber),
                      onPressed: () {
                        paytype != null
                            ? showModal()
                            : snackbar("Select payment option");
                      },
                      child: const MainText(
                          title: "Continue", size: 12, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('cart')
                          .where('userID', isEqualTo: currentuser.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              if (snapshot.hasData) {
                                AddtoCart crt = AddtoCart.fromdocument(
                                    snapshot.data!.docs[index].data());

                                return Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: ListTile(
                                    trailing: IconButton(
                                        onPressed: () {
                                          deleteItem(crt.cartsID);
                                        },
                                        icon: const Icon(Icons.delete)),
                                    title: Text(
                                      "${crt.name}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                    subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Php ${crt.totalprice}0"),
                                          Text("Quantity: ${crt.quantity}"),
                                        ]),
                                    leading: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              NetworkImage("${crt.imagelink}"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: Text("Add to Cart Now"),
                                );
                              }
                            },
                          );
                        }
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: total == 0
                                ? const Text("No available item in the cart")
                                : const Text("Pay the exact amount"),
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
                              if (currentuser.topup! < total) {
                                snackbar("you don't have enough balance");
                              } else {
                                if (total != 0) {
                                  setState(() {
                                    ischeckedout = true;
                                  });
                                }
                              }
                            },
                            child: total != 0
                                ? const MainText(
                                    title: "Purchase",
                                    size: 12,
                                    color: Color.fromARGB(255, 20, 15, 15),
                                  )
                                : const MainText(
                                    title: "No Item available",
                                    size: 12,
                                    color: Color.fromARGB(255, 20, 15, 15),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Future showModal() async {
    await showDialog(
        context: context,
        builder: (context) {
          return isloading
              ? const Center(child: CircularProgressIndicator())
              : AlertDialog(
                  title: const Text("Confirm Order"),
                  content: const MainText(
                      title:
                          "To continue please confirm your order if it is correct",
                      size: 12,
                      color: Colors.black),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel")),
                    TextButton(
                        onPressed: () {
                          isloading ? null : check();
                          Navigator.pop(context);
                        },
                        child: const Text("Confirm")),
                  ],
                );
        });
  }

  void updateBuyingTotal() async {
    final toptotal = currentuser.topup;
    final buytotal = total;
    final overalltotal = toptotal! - buytotal;
    debugPrint("$overalltotal");

    try {
      await FirebaseFirestore.instance
          .collection('student')
          .doc(currentuser.uid)
          .update({'topup': overalltotal}).then(
              (value) => debugPrint("Balance updated"));
    } catch (error) {
      debugPrint("$error");
    }
  }

  void deleteItem(id) async {
    await FirebaseFirestore.instance.collection('cart').doc(id).delete();
    setState(() {});
  }

  void check() async {
    DocumentSnapshot docs = await FirebaseFirestore.instance
        .collection('checkout')
        .doc(currentuser.uid)
        .get();

    if (docs.exists) {
      snackbar("You still have pending orders");
    } else {
      checkout();
    }
  }

  Future<void> checkout() async {
    setState(() {
      isloading = true;
    });
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('cart')
        .where('userID', isEqualTo: currentuser.uid)
        .get();
    Orders ord = Orders();
    try {
      if (snapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> checkoutDocs = [];

        for (var doc in snapshot.docs) {
          AddtoCart crt = AddtoCart.fromdocument(doc.data());
          ord.prdID = crt.prdID;
          ord.ordersID = crt.cartsID;
          ord.userID = crt.userID;
          ord.name = crt.name;
          ord.totalprice = crt.totalprice;
          ord.quantity = crt.quantity;
          ord.description = crt.description;
          ord.payementType = paytype;
          ord.imagelink = crt.imagelink;
          ord.onaccept = false;
          checkoutDocs.add(ord.tomap());
        }

        // Store the checkout docs in Firestore
        await FirebaseFirestore.instance
            .collection('checkout')
            .doc(currentuser.uid)
            .set({
          'name': currentuser.username,
          'paytype': paytype,
          'school ID': currentuser.userschID,
          'userID': currentuser.uid,
          'total': total,
          'items': checkoutDocs
        }).then((value) =>
                paytype == "CPU E-wallet" ? updateBuyingTotal() : null);

        // Clear the cart after successful checkout
        for (var doc in snapshot.docs) {
          await doc.reference.delete();
          setState(() {});
        }
        setState(() {
          isloading = false;
          ischeckedout = false;
          //
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const QRgenerator()));
        });
        // Show a success message or navigate to a success screen
      }
    } catch (error) {
      debugPrint("$error");
    }
  }
}
