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
              title: const Center(
                child: MainText(
                  title: "CPU-Dining",
                  size: 14,
                  color: Colors.amber,
                  fnt: FontWeight.bold,
                ),
              ),
              leading: IconButton(
                icon: const DrawerButtonIcon(),
                onPressed: () {
                  scaffoldkey.currentState!.openDrawer();
                },
              ),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.qr_code)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.notifications)),
                IconButton(
                    onPressed: () {
                      isloading ? null : logout();
                    },
                    icon: const Icon(Icons.logout)),
              ],
            ),
            body: SingleChildScrollView(
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
            )),
      ),
    );
  }

  void logout() async {
    final navigator = Navigator.of(context);
    setState(() {
      isloading = true;
    });
    await FirebaseAuth.instance.signOut();
    setState(() {
      isloading = false;
    });
    navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: ((context) => const AuthLogin())),
        (route) => false);
  }
}
