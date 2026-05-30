import 'package:eo_app/models/event_organizer.dart';

const String _venueImage =
    'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?w=600';
const String _profileImage =
    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400';

class EOService {
  // TODO: Ganti implementasi ini dengan HTTP request ke NestJS backend
  // Contoh:
  // static Future<List<EventOrganizer>> getEOs() async {
  //   final response = await http.get(Uri.parse('https://your-api.com/eos'));
  //   if (response.statusCode == 200) {
  //     final List data = jsonDecode(response.body);
  //     return data.map((e) => EventOrganizer.fromJson(e)).toList();
  //   }
  //   throw Exception('Failed to load EOs');
  // }

  static List<EventOrganizer> getEOs() {
    return List.generate(
      8,
      (i) => EventOrganizer(
        id: 'eo_$i',
        name: "EO's Name",
        imageUrl: _venueImage,
        profileImageUrl: _profileImage,
        location: 'Jakarta Selatan',
        rating: 5.0,
      ),
    );
  }

  // TODO: getEOById(String id) -> GET /eos/:id
  // static Future<EventOrganizer> getEOById(String id) async { ... }

  // TODO: getReviews(String eoId) -> GET /eos/:id/reviews
  // static Future<List<Review>> getReviews(String eoId) async { ... }
}