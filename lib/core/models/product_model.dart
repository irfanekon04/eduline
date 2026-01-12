class ProductModel {
  final String id;
  final String name;
  final Map<String, dynamic>? data;

  ProductModel({required this.id, required this.name, this.data});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'] ?? 'No Name',
      data: json['data'] as Map<String, dynamic>?,
    );
  }
}
