import 'dart:async';

import 'package:cpudining/components/component/ListOrder.user.dart';
import 'package:cpudining/components/component/listview.item.dart';
import 'package:cpudining/model/product.class.dart';
import 'package:cpudining/packages/exports.dart';
import 'package:cpudining/pages/addCartView.dart';
import 'package:cpudining/pages/orders.page.dart';

class Homepge extends StatefulWidget {
  const Homepge({super.key});

  @override
  State<Homepge> createState() => _HomepgeState();
}

class _HomepgeState extends State<Homepge> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  List product = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        drawer: const SafeArea(
          child: AdminDrawerComponent(),
        ),
        key: scaffoldkey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 190,
          leading: const Center(
            child: MainText(
              title: "CPU-Dining (Student)",
              size: 14,
              fnt: FontWeight.bold,
              color: Colors.amber,
            ),
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddToCartView()));
                    },
                    icon: const Icon(Icons.local_grocery_store_rounded)),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('cart')
                        .where("userID", isEqualTo: currentuser.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Text("0");
                      } else {
                        return Text("${snapshot.data!.docs.length}");
                      }
                    })
              ],
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const OrderPage())));
                },
                icon: const Icon(Icons.notifications)),
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AuthLogin()),
                          (route) => false));
                },
                icon: const Icon(Icons.logout)),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: onRefreshitem,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ListViewItems(),
                  const SizedBox(
                    height: 10,
                  ),
                  const MainText(
                      title: "Order now", size: 12, color: Colors.black),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: product.length,
                      itemBuilder: ((context, index) {
                        return ListViewOrderComponent(
                          prd: product[index] as Products,
                        );
                      })),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    onRefreshitem();
    super.initState();
  }

  // Future<void> oncart() async {
  //   final cartData = await FirebaseFirestore.instance
  //       .collection('cart')
  //       .where("userID", isEqualTo: currentuser.uid)
  //       .get();

  //   if (mounted) {
  //     setState(() {
  //       cartnum = cartData.docs.length;
  //     });
  //   } else {
  //     dispose();
  //   }
  // }

  Future onRefreshitem() async {
    final data = await FirebaseFirestore.instance.collection('Products').get();

    if (mounted) {
      setState(() {
        product = List.from(data.docs.map((doc) => Products.fromdocument(doc)));
      });
    } else {
      dispose();
    }
  }
}
