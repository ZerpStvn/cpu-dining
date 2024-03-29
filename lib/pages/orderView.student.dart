import 'package:cpudining/packages/exports.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderViewStudent extends StatefulWidget {
  final String imagelink;
  final String name;
  final double totalprice;
  final int quantity;
  final String description;
  const OrderViewStudent(
      {super.key,
      required this.imagelink,
      required this.name,
      required this.totalprice,
      required this.quantity,
      required this.description});

  @override
  State<OrderViewStudent> createState() => _OrderViewStudentState();
}

class _OrderViewStudentState extends State<OrderViewStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.imagelink),
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.40),
                                  BlendMode.multiply),
                              fit: BoxFit.cover)),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back,
                                    color: Colors.white)),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.sort,
                                    color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 19,
              ),
              SizedBox(
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MainText(
                              title: widget.name,
                              size: 20,
                              fnt: FontWeight.bold,
                              color: Colors.black),
                          MainText(
                            size: 14,
                            fnt: FontWeight.normal,
                            color: Colors.grey,
                            title: "Php ${widget.totalprice}.00",
                          ),
                        ],
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MainText(
                              title: "Payment Type",
                              size: 20,
                              fnt: FontWeight.bold,
                              color: Colors.black),
                          MainText(
                            size: 14,
                            fnt: FontWeight.normal,
                            color: Colors.grey,
                            title: "Over the Counter",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const MainText(
                            title: "Total Quantity",
                            size: 20,
                            color: Colors.black,
                            fnt: FontWeight.bold),
                        MainText(
                            title: "${widget.quantity}",
                            size: 15,
                            color: Colors.grey),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey.withOpacity(0.30),
                    ),
                    const Column(
                      children: [
                        MainText(
                            title: "Rate",
                            size: 20,
                            color: Colors.black,
                            fnt: FontWeight.bold),
                        MainText(
                          title: "5.0",
                          size: 15,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey.withOpacity(0.30),
                    ),
                    const Column(
                      children: [
                        MainText(
                            title: "Cooking",
                            size: 20,
                            color: Colors.black,
                            fnt: FontWeight.bold),
                        MainText(
                          title: "5-10 min",
                          size: 15,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MainText(
                        title: "Description",
                        size: 20,
                        color: Colors.black,
                        fnt: FontWeight.bold),
                    MainText(
                      title: widget.description,
                      size: 12,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: QrImageView(
                  data: '${currentuser.uid}',
                  version: QrVersions.auto,
                  size: 220,
                  gapless: false,
                  errorStateBuilder: (cxt, err) {
                    return const Center(
                      child: Text(
                        'Uh oh! Something went wrong...',
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 10, backgroundColor: Colors.amber),
                    onPressed: () {},
                    child: MainText(
                        title: "Total Php ${widget.totalprice}.00",
                        size: 12,
                        color: const Color.fromARGB(255, 20, 15, 15)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
