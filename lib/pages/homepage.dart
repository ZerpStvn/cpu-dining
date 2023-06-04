import 'package:cpudining/components/controller/login.controller.dart';
import 'package:flutter/material.dart';

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
