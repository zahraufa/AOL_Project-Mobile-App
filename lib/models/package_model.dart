class PackageModel {
  final int id;
  final String name;
  final double price;
  final String description;

  PackageModel({required this.id, required this.name, required this.price, required this.description});

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['Package_ID'] ?? 0,
      name: json['Package_Name'] ?? '',
      price: double.tryParse(json['Package_Price'].toString()) ?? 0.0,
      description: json['Package_Description'] ?? '',
    );
  }
}