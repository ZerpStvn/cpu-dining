import '../../packages/exports.dart';

class AuthLogin extends StatefulWidget {
  const AuthLogin({super.key});

  @override
  State<AuthLogin> createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 140,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 110,
                        width: 110,
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/logo.png'))),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const MainText(
                        title: "CPU\nDINING",
                        size: 28,
                        color: Color(0xfff4CA39),
                        fnt: FontWeight.bold,
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30, left: 10),
                    child: SizedBox(
                      width: 210,
                      child: MainText(
                          title: "Enjoy Your Food With no Worries",
                          size: 24,
                          fnt: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              const LoginController()
            ],
          ),
        ),
      ),
    );
  }
}
