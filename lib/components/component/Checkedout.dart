import 'package:cpudining/model/orders.class.dart';
import 'package:cpudining/model/product.class.dart';
import 'package:cpudining/packages/exports.dart';
import 'package:uuid/uuid.dart';

import '../controller/qr.order.dart';

class CheckedOut extends StatefulWidget {
  final Products prd;
  final int qnty;
  final double totalprice;
  const CheckedOut(
      {super.key,
      required this.prd,
      required this.totalprice,
      required this.qnty});

  @override
  State<CheckedOut> createState() => _CheckedOutState();
}

class _CheckedOutState extends State<CheckedOut> {
  String uniqID = const Uuid().v4();
  bool isloading = false;
  bool ischecked = false;

  snackbar(String? title) {
    final snack = SnackBar(content: Text(title!));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      NetworkImage("${widget.prd.imagelink}"),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MainText(
                              title: "${widget.prd.name}",
                              size: 19,
                              fnt: FontWeight.bold,
                              color: Colors.black),
                          MainText(
                              title: "Php ${widget.totalprice}0",
                              size: 13,
                              fnt: FontWeight.bold,
                              color: Colors.grey),
                        ],
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.check_circle_outline_rounded,
                    color: Colors.green,
                    size: 30,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
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
                    title: "Debit/Credit Card", size: 14, color: Colors.black),
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
                    ischecked = !ischecked;
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
                trailing: ischecked
                    ? const Icon(
                        Icons.check_circle_outline_rounded,
                        color: Colors.green,
                        size: 13,
                      )
                    : const Text(""),
              ),
              const SizedBox(
                height: 140,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 10, backgroundColor: Colors.amber),
                    onPressed: () {
                      ischecked
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
        ));
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
                          checkout();
                        },
                        child: const Text("Confirm")),
                  ],
                );
        });
  }

  Future<void> checkout() async {
    setState(() {
      isloading = true;
    });

    Orders ord = Orders();
    List<Map<String, dynamic>> checkoutDocs = [];

    try {
      ord.prdID = "${widget.prd.prdID}";
      ord.ordersID = uniqID;
      ord.userID = "${currentuser.uid}";
      ord.name = "${widget.prd.name}";
      ord.totalprice = double.parse("${widget.totalprice}");
      ord.imagelink = "${widget.prd.imagelink}";
      ord.quantity = int.parse("${widget.qnty}");
      ord.description = "${widget.prd.description}";
      ord.payementType = "Over the Counter";
      ord.onaccept = false;
      checkoutDocs.add(ord.tomap());

      // Store the checkout docs in Firestore
      await FirebaseFirestore.instance
          .collection('checkout')
          .doc(currentuser.uid)
          .set({
        'name': currentuser.username,
        'school ID': currentuser.userschID,
        'userID': currentuser.uid,
        'total': widget.totalprice,
        'items': checkoutDocs
      }).then((value) => snackbar("item checkout"));
      setState(() {
        isloading = false;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const QRgenerator()));
      });
    } catch (error) {
      snackbar("unable to checkout");
    }
  }
  //
}
