class PackageModel {
  final String id;
  final String eventType;
  final String price;
  final List<String> includes;
  final String imageUrl;

  const PackageModel({
    required this.id,
    required this.eventType,
    required this.price,
    required this.includes,
    required this.imageUrl,
  });

  // TODO: fromJson constructor untuk data dari backend
  // factory PackageModel.fromJson(Map<String, dynamic> json) {
  //   return PackageModel(
  //     id: json['id'],
  //     eventType: json['event_type'],
  //     price: json['price'],
  //     includes: List<String>.from(json['includes']),
  //     imageUrl: json['image_url'],
  //   );
  // }

  int get priceValue =>
      int.tryParse(price.replaceAll('Rp', '').replaceAll('.', '').trim()) ?? 0;
}