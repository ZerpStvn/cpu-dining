import 'package:cpudining/model/product.class.dart';
import 'package:cpudining/packages/exports.dart';

class ProductEdit extends StatefulWidget {
  final Products prd;
  const ProductEdit({super.key, required this.prd});

  @override
  State<ProductEdit> createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  final TextEditingController productname = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController description = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool isloading = false;
  bool isupdate = false;

  @override
  void initState() {
    productname.text = "${widget.prd.name}";
    price.text = "${widget.prd.price}";
    quantity.text = "${widget.prd.quantity}";
    description.text = "${widget.prd.description}";
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    productname.dispose();
    price.dispose();
    quantity.dispose();
    quantity.dispose();
    description.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              width: width,
              height: 200,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    image: DecorationImage(
                        image: NetworkImage("${widget.prd.imagelink}"),
                        fit: BoxFit.cover)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: productname,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Product name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: price,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter the price";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Price',
                              labelStyle: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: quantity,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter the quantity";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Quantity',
                              labelStyle: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      textAlignVertical: TextAlignVertical.top,
                      maxLines: 4,
                      maxLength: 250,
                      controller: description,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Product description";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isloading
                        ? const Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.transparent,
                              color: Colors.amber,
                            ),
                          )
                        : Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  width: width,
                                  height: 55,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 10,
                                        backgroundColor: Colors.amber),
                                    onPressed: () {
                                      update();
                                    },
                                    child: const MainText(
                                        title: "Update",
                                        size: 12,
                                        color: Colors.white),
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
                                      delete();
                                    },
                                    icon: const Icon(
                                        Icons.delete_outline_rounded),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void delete() async {
    setState(() {
      isloading = true;
    });
    await FirebaseFirestore.instance
        .collection('Products')
        .doc("${widget.prd.prdID}")
        .delete()
        .then((value) => setState(() {
              isloading = false;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const AdminHomepage())),
                  (route) => false);
            }));
  }

  snackbar(String? title) {
    final snack = SnackBar(content: Text(title!));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  void update() async {
    setState(() {
      isloading = true;
    });
    try {
      Products prds = Products();
      prds.name = productname.text;
      prds.price = double.parse(price.text);
      prds.quantity = int.parse(quantity.text);
      prds.description = description.text;
      prds.imagelink = "${widget.prd.imagelink}";
      prds.orderstatus = true;
      prds.prdID = "${widget.prd.prdID}";
      await FirebaseFirestore.instance
          .collection('Products')
          .doc("${widget.prd.prdID}")
          .update(prds.tomap())
          .then((value) => setState(() {
                isloading = false;
              }));
    } catch (error) {
      snackbar("error updating the item");
    }
  }
}
