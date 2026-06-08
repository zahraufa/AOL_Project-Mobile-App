class ServiceModel {
  final int id;
  final String name;
  final double price;
  final String description;

  ServiceModel({required this.id, required this.name, required this.price, required this.description});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['EO_services_ID'] ?? 0,
      name: json['services']?['Service_name'] ?? json['Additional_Feature'] ?? 'Unknown Add-on',
      price: double.tryParse(json['Service_Price'].toString()) ?? 0.0,
      description: json['Service_Description'] ?? '',
    );
  }
}