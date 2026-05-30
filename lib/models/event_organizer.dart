class EventOrganizer {
  final String id;
  final String name;
  final String imageUrl;
  final String profileImageUrl;
  final String location;
  final double rating;

  const EventOrganizer({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.profileImageUrl,
    required this.location,
    required this.rating,
  });

  // TODO: fromJson constructor untuk data dari backend
  // factory EventOrganizer.fromJson(Map<String, dynamic> json) {
  //   return EventOrganizer(
  //     id: json['id'],
  //     name: json['name'],
  //     imageUrl: json['image_url'],
  //     profileImageUrl: json['profile_image_url'],
  //     location: json['location'],
  //     rating: (json['rating'] as num).toDouble(),
  //   );
  // }
}