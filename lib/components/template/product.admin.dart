import 'package:cpudining/components/component/product.component.dart';
import 'package:cpudining/model/product.class.dart';
import 'package:cpudining/packages/exports.dart';

class ProductAdmin extends StatefulWidget {
  const ProductAdmin({super.key});

  @override
  State<ProductAdmin> createState() => _ProductAdminState();
}

class _ProductAdminState extends State<ProductAdmin> {
  List product = [];

  @override
  void initState() {
    getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          getProduct();
                        });
                      },
                      icon: const Icon(Icons.refresh)),
                  const Text("Refresh"),
                ],
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: product.length,
              itemBuilder: ((context, index) {
                return ProductComponent(
                  prd: product[index] as Products,
                );
              })),
        ),
      ],
    );
  }

  Future getProduct() async {
    final data = await FirebaseFirestore.instance.collection('Products').get();

    if (mounted) {
      setState(() {
        product = List.from(data.docs.map((doc) => Products.fromdocument(doc)));
      });
    } else {
      dispose();
    }
  }
}
