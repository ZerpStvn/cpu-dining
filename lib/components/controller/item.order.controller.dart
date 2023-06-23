import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpudining/components/component/Checkedout.dart';
import 'package:cpudining/components/controller/login.controller.dart';
import 'package:cpudining/constant/fontstyle.dart';
import 'package:cpudining/model/addtocart.dart';
import 'package:cpudining/model/product.class.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ItemController extends StatefulWidget {
  final Products prd;
  const ItemController({super.key, required this.prd});

  @override
  State<ItemController> createState() => _ItemControllerState();
}

class _ItemControllerState extends State<ItemController> {
  int qnty = 1;
  double? price;
  double? totalprice;

  @override
  void initState() {
    qnty;
    totalprice = price;

    super.initState();
  }

  snackbar(String? title) {
    final snack = SnackBar(content: Text(title!));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  @override
  Widget build(BuildContext context) {
    price = double.parse("${widget.prd.price}");
    totalprice ??= price;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
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
                              image: NetworkImage("${widget.prd.imagelink}"),
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.40),
                                  BlendMode.multiply),
                              fit: BoxFit.cover)),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              title: "${widget.prd.name}",
                              size: 20,
                              fnt: FontWeight.bold,
                              color: Colors.black),
                          MainText(
                              title: totalprice == null
                                  ? "Php ${price}0"
                                  : "Php ${totalprice}0",
                              size: 14,
                              fnt: FontWeight.normal,
                              color: Colors.grey),
                        ],
                      ),
                      Card(
                        elevation: 5,
                        child: Row(children: [
                          IconButton(
                              onPressed: () {
                                qnty == 1
                                    ? null
                                    : setState(() {
                                        --qnty;
                                        totalprice = price! * qnty;
                                      });
                              },
                              icon: const Icon(Icons.horizontal_rule)),
                          MainText(
                              title: "$qnty",
                              size: 20,
                              fnt: FontWeight.bold,
                              color: Colors.grey),
                          IconButton(
                              onPressed: () {
                                qnty == widget.prd.quantity
                                    ? null
                                    : setState(() {
                                        ++qnty;
                                        totalprice = price! * qnty;
                                        debugPrint("$price");
                                      });
                              },
                              icon: const Icon(Icons.add)),
                        ]),
                      )
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
                            title: "Quantity",
                            size: 20,
                            color: Colors.black,
                            fnt: FontWeight.bold),
                        MainText(
                            title: "${widget.prd.quantity}",
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
                      title: "${widget.prd.description}",
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
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 10, backgroundColor: Colors.amber),
                          onPressed: () {
                            if (qnty == 0) {
                              snackbar("Add quantity to your order");
                            } else {
                              check();
                            }
                          },
                          child: const MainText(
                              title: "Purchase",
                              size: 12,
                              color: Color.fromARGB(255, 20, 15, 15)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                          onPressed: () {
                            //
                            addToCart();
                          },
                          icon: const Icon(Icons.local_grocery_store),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addToCart() async {
    String uniqID = const Uuid().v4();
    final cartcolllection = FirebaseFirestore.instance.collection('cart');
    AddtoCart crt = AddtoCart();
    crt.prdID = widget.prd.prdID;
    crt.cartsID = uniqID;
    crt.userID = currentuser.uid;
    crt.name = widget.prd.name;
    crt.totalprice = totalprice;
    crt.quantity = qnty;
    crt.description = widget.prd.description;
    crt.imagelink = widget.prd.imagelink;
    try {
      await cartcolllection
          .doc(uniqID)
          .set(crt.tomap())
          .then((value) => snackbar("Item Added"));
    } catch (error) {
      snackbar("Unable to add the item");
    }
  }

  void check() async {
    final navigator = Navigator.of(context);
    DocumentSnapshot docs = await FirebaseFirestore.instance
        .collection('checkout')
        .doc(currentuser.uid)
        .get();
    if (docs.exists) {
      snackbar("You still have pending orders");
    } else {
      navigator.push(MaterialPageRoute(
          builder: (context) => CheckedOut(
                prd: widget.prd,
                totalprice: totalprice!,
                qnty: qnty,
              )));
    }
  }
}
