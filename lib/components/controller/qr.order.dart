import 'package:cpudining/components/controller/login.controller.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../constant/fontstyle.dart';
import '../../pages/homepage.dart';

class QRgenerator extends StatefulWidget {
  const QRgenerator({
    super.key,
  });

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
                data: '${currentuser.uid}',
                version: QrVersions.auto,
                size: 280,
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
                height: 130,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 10, backgroundColor: Colors.amber),
                    onPressed: () {
                      snackbar("unable to download. Please take a Screenshot");
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
