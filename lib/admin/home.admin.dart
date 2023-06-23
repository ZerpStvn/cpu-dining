import 'package:cpudining/components/controller/scanner.dart';

import '../packages/exports.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({super.key});

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage>
    with TickerProviderStateMixin {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  late TabController tabs;
  bool isloading = false;

  @override
  void initState() {
    tabs = TabController(length: 2, vsync: this);
    tabs.animateTo(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DefaultTabController(
        length: 2,
        initialIndex: 1,
        child: Scaffold(
            key: scaffoldkey,
            drawer: const SafeArea(
              child: AdminDrawerComponent(),
            ),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leadingWidth: 180,
              leading: const Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: MainText(
                    title: "CPU-Dining (Admin)",
                    size: 14,
                    color: Colors.amber,
                    fnt: FontWeight.bold,
                  ),
                ),
              ),
              // leading: IconButton(
              //   icon: const DrawerButtonIcon(),
              //   onPressed: () {
              //     scaffoldkey.currentState!.openDrawer();
              //   },
              // ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QrScanner()));
                    },
                    icon: const Icon(Icons.qr_code)),
                IconButton(
                    onPressed: () {
                      isloading ? null : logout();
                    },
                    icon: const Icon(Icons.logout)),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: getOrders,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    CardOrders(width: width),
                    const SizedBox(
                      height: 20,
                    ),
                    TabBar(
                        padding: const EdgeInsets.all(8),
                        indicatorColor: Colors.amber,
                        labelColor: Colors.black,
                        dividerColor: Colors.transparent,
                        controller: tabs,
                        tabs: const [Text("Orders"), Text("Products")]),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: height,
                      child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: tabs,
                          children: const [
                            OrdersAdmin(),
                            ProductAdmin(),
                          ]),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  snackbar(String? title) {
    final snack = SnackBar(content: Text(title!));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  Future getOrders() async {
    try {
      await FirebaseFirestore.instance.collection('orders').get();
      await FirebaseFirestore.instance.collection('products').get();
    } catch (error) {
      return "to items exixt";
    }
  }

  void logout() async {
    final navigator = Navigator.of(context);
    setState(() {
      isloading = true;
    });
    try {
      await FirebaseAuth.instance.signOut();
    } catch (error) {
      snackbar("Unable to logout");
    }
    setState(() {
      isloading = false;
    });
    navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: ((context) => const AuthLogin())),
        (route) => false);
  }
}
