class Pizza {
  final int? id;
  final String? pizzaName;
  final String? description;
  final double? price;
  final String? imageUrl;

  Pizza({
    this.id,
    this.pizzaName,
    this.description,
    this.price,
    this.imageUrl,
  });

  factory Pizza.fromJson(Map<String, dynamic> json) {
    // User-friendly defaults: if a field is missing or invalid, supply a
    // sensible default so the UI doesn't display literal 'null'. This
    // follows Praktikum 2 Step 10.
    final idValue = json['id'];
    final int id = int.tryParse(idValue?.toString() ?? '') ?? 0;

    final pizzaName = json['pizzaName'] != null ? json['pizzaName'].toString() : 'No name';
    final description = json['description'] != null ? json['description'].toString() : '';

    final priceValue = json['price'];
    final double price = double.tryParse(priceValue?.toString() ?? '') ?? 0.0;

    final imageUrl = json['imageUrl'] != null ? json['imageUrl'].toString() : '';

    return Pizza(
      id: id,
      pizzaName: pizzaName,
      description: description,
      price: price,
      imageUrl: imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pizzaName': pizzaName,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
