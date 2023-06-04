import 'package:cpudining/packages/exports.dart';

class Homepge extends StatefulWidget {
  const Homepge({super.key});

  @override
  State<Homepge> createState() => _HomepgeState();
}

class _HomepgeState extends State<Homepge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        body: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Text("${currentuser.userdepartment}")
          ],
        ));
  }
}
