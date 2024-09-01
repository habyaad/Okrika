class CategoryModel {
  final int id;
  final String category;

  CategoryModel({
    required this.id,
    required this.category,
  });

  // Factory method to create a CategoryModel from JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      category: json['category'],
    );
  }

  // Method to convert a CategoryModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
    };
  }

  // Function to parse a list of CategoryModel from JSON
  static List<CategoryModel> parseCategoryList(List<dynamic> jsonList) {
    return jsonList.map((json) => CategoryModel.fromJson(json)).toList();
  }
}
