import 'package:cpudining/components/controller/editController/edit.product.dart';
import 'package:cpudining/model/product.class.dart';

import '../../packages/exports.dart';

class ProductComponent extends StatefulWidget {
  final Products prd;
  const ProductComponent({super.key, required this.prd});

  @override
  State<ProductComponent> createState() => _ProductComponentState();
}

class _ProductComponentState extends State<ProductComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Card(
        color: const Color.fromARGB(255, 255, 255, 255),
        elevation: 5,
        child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductEdit(prd: widget.prd)));
          },
          contentPadding: const EdgeInsets.all(10),
          leading: Container(
            height: 90,
            width: 110,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("${widget.prd.imagelink}"),
                    fit: BoxFit.cover)),
          ),
          title: Text("${widget.prd.name}"),
          subtitle: MainText(
              title:
                  "Php ${widget.prd.price}0\nAvailable: ${widget.prd.quantity}",
              size: 10,
              color: Colors.grey),
          trailing: const Icon(Icons.receipt),
        ),
      ),
    );
  }
}
