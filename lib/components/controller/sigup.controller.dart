import '../../packages/exports.dart';

class SignupController extends StatefulWidget {
  const SignupController({super.key});

  @override
  State<SignupController> createState() => _SignupControllerState();
}

class _SignupControllerState extends State<SignupController> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController username = TextEditingController();
  final TextEditingController course = TextEditingController();
  final TextEditingController department = TextEditingController();
  final TextEditingController schlID = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwrdController = TextEditingController();
  UsersClass users = UsersClass();
  bool passwordChar = true;
  bool unchecked = false;
  String? errormessage;
  bool isloading = false;

  @override
  void dispose() {
    username.dispose();
    course.dispose();
    department.dispose();
    schlID.dispose();
    emailController.dispose();
    schlID.dispose();
    passwrdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthsize = MediaQuery.of(context).size.width;
    return Form(
      key: formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: username,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter your full name";
              }
              return null;
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person),
              labelText: 'Name',
              labelStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: schlID,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter your University ID";
              }
              return null;
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.school),
              labelText: 'University ID',
              labelStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Checkbox(
                  value: unchecked,
                  onChanged: (bool? value) {
                    setState(() {
                      unchecked = value!;
                    });
                  }),
              const MainText(
                  title: "Junior High School", size: 12, color: Colors.black)
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          unchecked
              ? Container()
              : Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: department,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Deparments";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.school_sharp),
                          labelText: 'Department',
                          labelStyle:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: course,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Course";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.school_sharp),
                          labelText: 'Course',
                          labelStyle:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                    ),
                  ],
                ),
          const SizedBox(
            height: 20,
          ),
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
                    signUP(emailController.text, passwrdController.text);
                  },
                  child: const MainText(
                      title: "SIGNUP", size: 14, color: Colors.black)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: isloading
                ? const CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    color: Colors.amber,
                  )
                : TextButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const AuthLogin())),
                        (route) => false),
                    child: const MainText(
                        title: "Already have an Account? Login",
                        size: 12,
                        color: Colors.blueAccent)),
          )
        ],
      ),
    );
  }

  void signupFireStore() async {
    final navigator = Navigator.of(context);
    User? currentUser = FirebaseAuth.instance.currentUser;
    users.uid = currentUser!.uid;
    users.username = username.text;
    users.userschID = schlID.text;
    users.userdepartment = unchecked ? "Junior High School" : department.text;
    users.usercourse = unchecked ? "Junior High School" : course.text;
    users.useremail = emailController.text;
    users.userpassword = passwrdController.text;
    users.userrole = 1;

    await FirebaseFirestore.instance
        .collection('student')
        .doc(currentUser.uid)
        .set(users.tomap());

    debugPrint("Account Created");
    navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const AuthLogin()),
        (route) => false);
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

  void signUP(String email, String password) async {
    setState(() {
      isloading = true;
    });
    if (formkey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => signupFireStore());
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errormessage = "Your email address is invalid.";
            handleError(errormessage);
            break;
          case "wrong-password":
            errormessage = "Your password is wrong.";
            handleError(errormessage);
            break;
          case "user-not-found":
            errormessage = "User with this email doesn't exist.";
            handleError(errormessage);
            break;
          case "user-disabled":
            errormessage = "User with this email has been disabled.";
            handleError(errormessage);
            break;
          case "too-many-requests":
            errormessage = "Too many requests";
            handleError(errormessage);
            break;
          case "operation-not-allowed":
            errormessage = "Signing in with Email and Password is not enabled.";
            handleError(errormessage);
            break;
          default:
            errormessage = "An undefined Error happened.";
            handleError(errormessage);
        }
      }
    }
    setState(() {
      isloading = false;
    });
  }
}
