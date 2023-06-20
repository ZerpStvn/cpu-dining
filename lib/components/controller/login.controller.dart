import '../../packages/exports.dart';

UsersClass currentuser = UsersClass();

class LoginController extends StatefulWidget {
  const LoginController({super.key});

  @override
  State<LoginController> createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {
  final formkey = GlobalKey<FormState>();
  final userAuthenticate = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwrdController = TextEditingController();
  bool passwordChar = true;
  String? errorMessage;
  bool isloading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwrdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthsize = MediaQuery.of(context).size.width;
    return Form(
      key: formkey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter your email";
              }
              return null;
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email),
              labelText: 'Email',
              labelStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: passwrdController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter your password";
              }
              return null;
            },
            obscureText: passwordChar,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      passwordChar = !passwordChar;
                    });
                  },
                  icon: passwordChar
                      ? const Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
                        )
                      : const Icon(
                          Icons.visibility_outlined,
                          color: Colors.grey,
                        )),
              prefixIcon: const Icon(Icons.key),
              labelText: 'password',
              labelStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 55.0,
            width: widthsize,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xfff4CA39),
                  ),
                  onPressed: () {
                    isloading == false
                        ? userlogin(
                            emailController.text, passwrdController.text)
                        : null;
                  },
                  child: const MainText(
                      title: "LOGIN", size: 14, color: Colors.black)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          isloading
              ? const CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: Colors.amber,
                )
              : TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const AuthSignUp()))),
                  child: const MainText(
                      title: "Create Account",
                      size: 12,
                      color: Colors.blueAccent)),
        ],
      ),
    );
  }

  Future getlogUser() async {
    final navigator = Navigator.of(context);
    User? userlog = FirebaseAuth.instance.currentUser;
    DocumentSnapshot docs = await FirebaseFirestore.instance
        .collection('student')
        .doc(userlog!.uid)
        .get();
    if (docs.exists) {
      currentuser = UsersClass.fromDucoments(docs);
    } else {
      debugPrint("error");
    }

    if (currentuser.userrole == 1) {
      navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: ((context) => const AdminHomepage())),
          (route) => false);
      //debugPrint("Admin");
      isloading = false;
    } else {
      navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: ((context) => const Homepge())),
          (route) => false);
      isloading = false;
    }
    setState(() {
      isloading = false;
      //debugPrint("false");
    });
  }

  snackbar(String? title) {
    final snack = SnackBar(content: Text(title!));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  void handleError(String? error) {
    setState(() {
      isloading = false;
      snackbar(error);
    });
  }

  void userlogin(String email, String password) async {
    setState(() {
      isloading = true;
    });
    if (formkey.currentState!.validate()) {
      try {
        await userAuthenticate
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => getlogUser());
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address is invalid.";
            handleError(errorMessage);
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            handleError(errorMessage);
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            handleError(errorMessage);
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            handleError(errorMessage);
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            handleError(errorMessage);
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            handleError(errorMessage);
            break;
          default:
            errorMessage =
                "An undefined error happened. Please try again later";
            handleError(errorMessage);
        }
      }
    }
  }
}
