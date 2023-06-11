import 'package:cpudining/components/component/Checkedout.dart';
import 'package:cpudining/constant/fontstyle.dart';
import 'package:cpudining/model/product.class.dart';
import 'package:flutter/material.dart';

class ItemController extends StatefulWidget {
  final Products prd;
  const ItemController({super.key, required this.prd});

  @override
  State<ItemController> createState() => _ItemControllerState();
}

class _ItemControllerState extends State<ItemController> {
  int qnty = 0;

  @override
  void initState() {
    qnty;
    super.initState();
  }

  snackbar(String? title) {
    final snack = SnackBar(content: Text(title!));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  @override
  Widget build(BuildContext context) {
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
                              title: "Php${widget.prd.price}0",
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
                                qnty == 0
                                    ? null
                                    : setState(() {
                                        --qnty;
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CheckedOut(prd: widget.prd)));
                            }
                          },
                          child: const MainText(
                              title: "Purchase", size: 12, color: Colors.white),
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
                          onPressed: () {},
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
}
