import 'package:cpudining/model/orders.class.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../constant/fontstyle.dart';
import '../../pages/homepage.dart';

class QRgenerator extends StatefulWidget {
  final Orders ord;
  const QRgenerator({super.key, required this.ord});

  @override
  State<QRgenerator> createState() => _QRgeneratorState();
}

class _QRgeneratorState extends State<QRgenerator> {
  @override
  void initState() {
    super.initState();
  }

  snackbar(String? title) {
    final snack = SnackBar(content: Text(title!));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: ((context) => const Homepge())),
                  (route) => false);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              QrImageView(
                data: '${widget.ord.ordersID}',
                version: 1,
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
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Column(
                children: [
                  Text("Ref: ${widget.ord.ordersID}"),
                  Text("Total: Php ${widget.ord.totalprice}0"),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Present this QR code \nto  CPU-Dining Counter",
                    textAlign: TextAlign.center,
                  )
                ],
              )),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 10, backgroundColor: Colors.amber),
                    onPressed: () {
                      snackbar("unable to download. Please take a Screen Shot");
                    },
                    child: const MainText(
                        title: "Download", size: 12, color: Colors.white),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
