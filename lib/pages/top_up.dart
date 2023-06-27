import 'package:cpudining/packages/exports.dart';

class TopUpView extends StatefulWidget {
  const TopUpView({super.key});

  @override
  State<TopUpView> createState() => _TopUpViewState();
}

class _TopUpViewState extends State<TopUpView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainText(
                  title: "Available Balanace",
                  size: 12,
                  color: Colors.white,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('student')
                        .doc(currentuser.uid)
                        .snapshots(),
                    builder: (context, snapshots) {
                      if (!snapshots.hasData) {
                        return MainText(
                          title: "₱ 0",
                          size: 25,
                          color: Colors.white,
                        );
                      } else {
                        UsersClass usr =
                            UsersClass.fromDucoments(snapshots.data!.data());
                        return MainText(
                          title:
                              usr.topup! < 0 ? "₱ 0.00" : "₱ ${usr.topup}.00",
                          size: 25,
                          color: Colors.white,
                        );
                      }
                    }),
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.credit_score_rounded,
                  color: Colors.white,
                  size: 34,
                )),
          ],
        ),
      ),
    );
  }
}
