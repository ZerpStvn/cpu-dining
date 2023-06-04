import 'package:cpudining/packages/exports.dart';

class ProductAdmin extends StatefulWidget {
  const ProductAdmin({super.key});

  @override
  State<ProductAdmin> createState() => _ProductAdminState();
}

class _ProductAdminState extends State<ProductAdmin> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Text("Product")],
    );
  }
}
