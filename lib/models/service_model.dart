class ServiceModel {
  final int id;
  final String name; 
  final double price;
  final String description;
  final bool isRequired;

  ServiceModel({
    required this.id, 
    required this.name, 
    required this.price, 
    required this.description,
    this.isRequired = false,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    final String nameStr = json['Service_Name'] ?? 'Unknown Add-on';
    
    final List<String> mandatoryNames = [
      'Rundown and Scriptwriting',
      'Master of Ceremony (MC)',
      'Tim Dokumentasi dan Fotografi',
      'Guest Management',
      'Show Controlling'
    ];

    return ServiceModel(
      id: json['Service_ID'] ?? 0,
      name: nameStr,
      price: double.tryParse(json['Price']?.toString() ?? '0') ?? 0.0,
      description: json['Description'] ?? '',
      isRequired: json['Is_Required'] ?? mandatoryNames.contains(nameStr),
    );
  }
}