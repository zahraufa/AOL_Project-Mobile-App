import 'package:eo_app/models/package_model.dart';

const String _venueImage =
    'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?w=600';

class PackageService {
  // TODO: Ganti implementasi ini dengan HTTP request ke backend
  // Contoh:
  // static Future<List<PackageModel>> getPackages(String eoId) async {
  //   final response = await http.get(
  //     Uri.parse('https://your-api.com/eos/$eoId/packages'),
  //   );
  //   if (response.statusCode == 200) {
  //     final List data = jsonDecode(response.body);
  //     return data.map((e) => PackageModel.fromJson(e)).toList();
  //   }
  //   throw Exception('Failed to load packages');
  // }

  static List<PackageModel> getPackages() {
    return const [
      PackageModel(
        id: 'pkg_1',
        eventType: 'Birthday Party',
        price: 'Rp5.000.000',
        includes: ['Room', 'MUA', 'Photographer', 'Decoration'],
        imageUrl: _venueImage,
      ),
      PackageModel(
        id: 'pkg_2',
        eventType: 'Wedding',
        price: 'Rp15.000.000',
        includes: ['Room', 'MUA', 'Photographer', 'Decoration', 'Catering'],
        imageUrl: _venueImage,
      ),
      PackageModel(
        id: 'pkg_3',
        eventType: 'Corporate Event',
        price: 'Rp8.000.000',
        includes: ['Room', 'Sound System', 'Photographer', 'Decoration'],
        imageUrl: _venueImage,
      ),
      PackageModel(
        id: 'pkg_4',
        eventType: 'Baby Shower',
        price: 'Rp3.500.000',
        includes: ['Room', 'MUA', 'Photographer', 'Decoration'],
        imageUrl: _venueImage,
      ),
      PackageModel(
        id: 'pkg_5',
        eventType: 'Anniversary',
        price: 'Rp6.000.000',
        includes: ['Room', 'MUA', 'Photographer', 'Decoration', 'Cake'],
        imageUrl: _venueImage,
      ),
    ];
  }

  // TODO: bookPackage(String packageId, String userId) -> kirim booking ke backend
  // static Future<bool> bookPackage(String packageId, String userId) async { ... }
}