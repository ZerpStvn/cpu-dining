import '../../packages/exports.dart';

class AdminDrawerComponent extends StatelessWidget {
  const AdminDrawerComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //final user = FirebaseAuth.instance.currentUser;
    double width = MediaQuery.of(context).size.width;
    return Drawer(
      width: width * 0.70,
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: Colors.amber),
              child: Container()),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            title: MainText(
                title: currentuser.userrole == 1 ? "Check Orders" : "Orders",
                size: 15,
                color: Colors.black),
          ),
          Divider(thickness: 1, color: Colors.grey.withOpacity(0.60)),
          const SizedBox(
            height: 20,
          ),
          currentuser.userrole == 1
              ? ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrdersForm()));
                  },
                  title: const MainText(
                      title: "Add products", size: 15, color: Colors.black),
                )
              : Container(),
          currentuser.userrole == 1
              ? Divider(thickness: 1, color: Colors.grey.withOpacity(0.60))
              : Container(),
          const ListTile(
            title:
                MainText(title: "Notifications", size: 15, color: Colors.black),
          ),
          Divider(thickness: 1, color: Colors.grey.withOpacity(0.60)),
          ListTile(
            title: MainText(
                title: currentuser.userrole == 1 ? "Users" : "Cart",
                size: 15,
                color: Colors.black),
          ),
          Divider(thickness: 1, color: Colors.grey.withOpacity(0.60)),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () async {
                final navigator = Navigator.of(context);
                await FirebaseAuth.instance.signOut();
                navigator.pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const AuthLogin()),
                    (route) => false);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout),
                  SizedBox(
                    width: 5,
                  ),
                  MainText(title: "Logout", size: 15, color: Colors.black),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const MainText(title: "Version 1.1", size: 15, color: Colors.black),
        ],
      ),
    );
  }
}
