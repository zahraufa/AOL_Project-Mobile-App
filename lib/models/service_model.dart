class ServiceModel {
  final int id;
  final String name; 
  final double price;
  final String description;

  ServiceModel({required this.id, required this.name, required this.price, required this.description});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['Service_ID'] ?? 0,
      name: json['Service_Name'] ?? 'Unknown Add-on',
      price: double.tryParse(json['Price']?.toString() ?? '0') ?? 0.0,
      description: json['Description'] ?? '',
    );
  }
}