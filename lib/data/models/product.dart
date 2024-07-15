class Product {
  final String id;
  String title;
  final double price;
  String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });
}
