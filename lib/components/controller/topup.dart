import 'package:cpudining/packages/exports.dart';

class TopUpController extends StatefulWidget {
  const TopUpController({super.key});

  @override
  State<TopUpController> createState() => _TopUpControllerState();
}

class _TopUpControllerState extends State<TopUpController> {
  final TextEditingController cardnum = TextEditingController();
  final TextEditingController expdate = TextEditingController();
  final TextEditingController cvv = TextEditingController();
  final TextEditingController postal_code = TextEditingController();

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/pngwing.com.png'))),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        MainText(
                            title: "Top Up using your \ncredit/Debit Card",
                            size: 13,
                            color: Colors.black)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: cardnum,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a card number";
                        }
                        String cleanednumber =
                            value.replaceAll(RegExp(r'\D+'), '');
                        RegExp cardPattern = RegExp(r'^[0-9]{13,19}$');
                        if (!cardPattern.hasMatch(cleanednumber)) {
                          return "Invalid Card details";
                        } else {
                          cardnum.text = value;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.credit_card),
                        labelText: 'Card Number',
                        labelStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          controller: expdate,
                          keyboardType: TextInputType.datetime,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter expiration date";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.date_range_outlined),
                            labelText: 'Expiration Date',
                            labelStyle: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextFormField(
                          controller: cvv,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter the CVV";
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password),
                            labelText: 'CVV',
                            labelStyle: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: postal_code,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your postal code";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.pin_drop),
                        labelText: 'Postal code',
                        labelStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber),
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          debugPrint("Validated");
                        }
                      },
                      child: MainText(
                          title: "Continue", size: 12, color: Colors.white)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
