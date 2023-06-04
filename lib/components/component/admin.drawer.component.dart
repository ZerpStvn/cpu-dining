import '../../packages/exports.dart';

class AdminDrawerComponent extends StatelessWidget {
  const AdminDrawerComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Drawer(
      width: width * 0.70,
      backgroundColor: Colors.white,
    );
  }
}
