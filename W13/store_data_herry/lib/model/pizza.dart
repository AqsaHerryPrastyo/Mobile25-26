// JSON key constants (Praktikum 3)
const String keyId = 'id';
const String keyName = 'pizzaName';
const String keyDescription = 'description';
const String keyPrice = 'price';
const String keyImage = 'imageUrl';

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
    final idValue = json[keyId];
    final int id = int.tryParse(idValue?.toString() ?? '') ?? 0;

    final pizzaName = json[keyName] != null ? json[keyName].toString() : 'No name';
    final description = json[keyDescription] != null ? json[keyDescription].toString() : '';

    final priceValue = json[keyPrice];
    final double price = double.tryParse(priceValue?.toString() ?? '') ?? 0.0;

    final imageUrl = json[keyImage] != null ? json[keyImage].toString() : '';

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
      keyId: id,
      keyName: pizzaName,
      keyDescription: description,
      keyPrice: price,
      keyImage: imageUrl,
    };
  }
}
