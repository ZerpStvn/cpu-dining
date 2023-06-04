class Products {
  String? name;
  double? price;
  int? quantity;
  String? description;
  String? imagelink;

  Products(
      {this.name, this.price, this.quantity, this.description, this.imagelink});

  factory Products.fromdocument(map) {
    return Products(
      name: map['name'],
      price: map['price'],
      quantity: map['quantity'],
      description: map['description'],
      imagelink: map['imagelink'],
    );
  }
  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'description': description,
      'imagelink': imagelink,
    };
  }
}
