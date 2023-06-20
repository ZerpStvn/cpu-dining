import 'package:cpudining/model/orders.class.dart';
import 'package:cpudining/packages/exports.dart';

class OrderViewStudent extends StatefulWidget {
  final Orders ord;
  const OrderViewStudent({super.key, required this.ord});

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
                              image: NetworkImage("${widget.ord.imagelink}"),
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
                              title: "${widget.ord.name}",
                              size: 20,
                              fnt: FontWeight.bold,
                              color: Colors.black),
                          MainText(
                            size: 14,
                            fnt: FontWeight.normal,
                            color: Colors.grey,
                            title: "Php ${widget.ord.totalprice}.00",
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const MainText(
                              title: "Payment Type",
                              size: 20,
                              fnt: FontWeight.bold,
                              color: Colors.black),
                          MainText(
                            size: 14,
                            fnt: FontWeight.normal,
                            color: Colors.grey,
                            title: "${widget.ord.payementType}",
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
                            title: "${widget.ord.quantity}",
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
                      title: "${widget.ord.description}",
                      size: 12,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
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
                        title: "Total Php ${widget.ord.totalprice}.00",
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
