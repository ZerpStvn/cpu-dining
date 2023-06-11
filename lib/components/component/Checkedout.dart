import 'package:cpudining/constant/fontstyle.dart';
import 'package:cpudining/model/product.class.dart';
import 'package:flutter/material.dart';

class CheckedOut extends StatefulWidget {
  final Products prd;
  const CheckedOut({super.key, required this.prd});

  @override
  State<CheckedOut> createState() => _CheckedOutState();
}

class _CheckedOutState extends State<CheckedOut> {
  snackbar(String? title) {
    final snack = SnackBar(content: Text(title!));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  bool ischecked = false;
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
                              title: "Php ${widget.prd.price}0",
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
                    title: "Comming soon", size: 10, color: Colors.grey),
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
                    title: "Comming soon", size: 10, color: Colors.grey),
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
          return AlertDialog(
            title: const Text("Confirm Order"),
            content: const MainText(
                title: "To continue please confirm your order if it is correct",
                size: 12,
                color: Colors.black),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel")),
              TextButton(onPressed: () {}, child: const Text("Confirm")),
            ],
          );
        });
  }
}
