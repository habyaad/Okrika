class ProductModel {
  final int? id;
  final int? category;
  final String? name;
  final double? price;
  final String? description;
  final String? imageUrl;

  ProductModel({
    required this.id,
    required this.category,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  // Factory method to create a ProductModel from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      // Ensures price is a double
      category: json['id'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  // Method to convert a ProductModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  // Function to parse a list of ProductModel from JSON
  static List<ProductModel> parseProductList(List<dynamic> jsonList) {
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }
}
