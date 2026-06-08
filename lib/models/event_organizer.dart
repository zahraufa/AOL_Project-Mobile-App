class EventOrganizerModel {
  final int id;
  final String name;
  final double rating;
  final String? image;
  final String address;

  EventOrganizerModel({
    required this.id,
    required this.name,
    required this.rating,
    this.image,
    required this.address,
  });

  factory EventOrganizerModel.fromJson(Map<String, dynamic> json) {
    return EventOrganizerModel(
      id: json['EO_ID'] ?? 0,
      name: json['EO_name'] ?? 'Unknown EO',
      rating: double.tryParse(json['EO_Rating'].toString()) ?? 0.0,
      image: json['EO_Image'],
      address: json['EO_Address'] ?? '',
    );
  }
}