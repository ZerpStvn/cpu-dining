import 'package:cpudining/components/controller/sigup.controller.dart';
import 'package:cpudining/packages/exports.dart';

class AuthSignUp extends StatefulWidget {
  const AuthSignUp({super.key});

  @override
  State<AuthSignUp> createState() => _AuthSignUpState();
}

class _AuthSignUpState extends State<AuthSignUp> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              MainText(title: "Signup", size: 26, color: Colors.black),
              SizedBox(
                height: 30,
              ),
              SignupController(),
            ],
          ),
        ),
      ),
    );
  }
}
