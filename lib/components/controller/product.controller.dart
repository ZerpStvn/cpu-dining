import 'dart:io';
import 'dart:io' as io;
import 'package:cpudining/model/product.class.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../packages/exports.dart';

class OrdersForm extends StatefulWidget {
  const OrdersForm({super.key});

  @override
  State<OrdersForm> createState() => _OrdersFormState();
}

class _OrdersFormState extends State<OrdersForm> {
  final TextEditingController productname = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController description = TextEditingController();
  final formkey = GlobalKey<FormState>();
  XFile? imagePath;
  final ImagePicker _pick = ImagePicker();
  var uniqID = const Uuid().v4();
  bool isloading = false;

  handlepickImage() async {
    XFile? image =
        await _pick.pickImage(source: ImageSource.gallery, imageQuality: 44);
    setState(() {
      imagePath = image;
    });
  }

  @override
  void initState() {
    uniqID;
    super.initState();
  }

  @override
  void dispose() {
    productname.dispose();
    price.dispose();
    quantity.dispose();
    quantity.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              width: width,
              height: 200,
              child: Container(
                color: Colors.amber,
                child: imagePath == null
                    ? const Center(
                        child: MainText(
                            title: "No image selected",
                            size: 12,
                            fnt: FontWeight.w300,
                            color: Colors.white),
                      )
                    : Image.file(
                        File(imagePath!.path),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 10, backgroundColor: Colors.amber),
                      onPressed: () {
                        handlepickImage();
                      },
                      child: const MainText(
                          title: "Add image", size: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: productname,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Product name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: price,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter the price";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Price',
                              labelStyle: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: quantity,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter the quantity";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Quantity',
                              labelStyle: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      textAlignVertical: TextAlignVertical.top,
                      maxLines: 4,
                      maxLength: 250,
                      controller: description,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Product description";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isloading
                        ? const Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.transparent,
                              color: Colors.amber,
                            ),
                          )
                        : SizedBox(
                            width: width,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 10, backgroundColor: Colors.amber),
                              onPressed: () {
                                createpost();
                              },
                              child: const MainText(
                                  title: "Create post",
                                  size: 12,
                                  color: Colors.white),
                            ),
                          )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<String> uploadImage() async {
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': imagePath!.path},
    );
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("item_$uniqID.jpg")
        .putFile(io.File(imagePath!.path), metadata);
    TaskSnapshot taskSnapshot = await uploadTask;
    String mediaURL = await taskSnapshot.ref.getDownloadURL();
    return mediaURL;
  }

  snackbar(String? title) {
    final snack = SnackBar(content: Text(title!));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  void createpost() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        isloading = true;
      });
      try {
        String photourl = await uploadImage();
        Products prd = Products();
        prd.prdID = uniqID;
        prd.name = productname.text;
        prd.price = double.parse(price.text);
        prd.quantity = int.parse(quantity.text);
        prd.description = description.text;
        prd.imagelink = photourl;
        prd.orderstatus = true;
        debugPrint(photourl);
        await FirebaseFirestore.instance
            .collection('Products')
            .doc(uniqID)
            .set(prd.tomap())
            .then((value) => setState(() {
                  snackbar("New Product Added");
                  uniqID;
                  isloading = false;
                }));
      } catch (error) {
        snackbar("Can't add product right now");
      }
    }
  }
}
