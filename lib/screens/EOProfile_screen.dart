import 'package:flutter/material.dart';
import '../models/event_organizer.dart';
import '../models/package_model.dart';
import '../services/api_services.dart';

class EoProfileScreen extends StatefulWidget {
  final EventOrganizerModel eo;

  const EoProfileScreen({Key? key, required this.eo}) : super(key: key);

  @override
  State<EoProfileScreen> createState() => _EoProfileScreenState();
}

class _EoProfileScreenState extends State<EoProfileScreen> {
  final ApiServices _apiServices = ApiServices();
  
  bool _isLoading = true;
  String _description = '';
  List<String> _categories = [];
  List<PackageModel> _packages = [];

  @override
  void initState() {
    super.initState();
    _fetchProfileDetails();
  }

  Future<void> _fetchProfileDetails() async {
    final data = await _apiServices.getEoDetails(widget.eo.id);
    
    if (data != null && mounted) {
      final String rawDesc = data['EO_Description'] ?? 'Penyedia layanan Event Organizer profesional untuk berbagai kebutuhan acara Anda.';
      
      final List<dynamic> rawCats = data['categories'] as List<dynamic>? ?? [];
      
      final List<dynamic> rawPkgs = data['packages'] as List<dynamic>? ?? 
                                    data['eo_package'] as List<dynamic>? ?? [];

      setState(() {
        _description = rawDesc;
        _categories = rawCats.map((c) => c.toString()).toList();
        _packages = rawPkgs.map((p) => PackageModel.fromJson(p)).toList();
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildStarRating(double rating) {
    int fullStars = rating.floor();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return const Icon(Icons.star, color: Colors.amber, size: 24);
        } else if (index == fullStars && rating % 1 != 0) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 24);
        } else {
          return const Icon(Icons.star_border, color: Colors.grey, size: 24);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // header
            SizedBox(
              height: 280,
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  ClipPath(
                    clipper: HeaderClipper(),
                    child: Container(
                      height: 220,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0D2546),
                        image: DecorationImage(
                          image: AssetImage('assets/images/ballroom.jpg'),
                          fit: BoxFit.cover,
                          opacity: 0.3,
                        ),
                      ),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Stack(
                            children: [

                              Align(
                                alignment: Alignment.topLeft,
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 1.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16),
                                  ),
                                ),
                              ),

                              const Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  'PROFILE',
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // profile
                  Positioned(
                    top: 130,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
                      ),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: widget.eo.image != null ? NetworkImage(widget.eo.image!) : null,
                        child: widget.eo.image == null ? const Icon(Icons.business, size: 50, color: Colors.grey) : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // eo name n desc
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Text(
                    widget.eo.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  
                  Container(height: 1.5, width: 120, color: Colors.black),
                  const SizedBox(height: 3),
                  Container(height: 0.5, width: 100, color: Colors.black),
                  const SizedBox(height: 16),

                  if (_isLoading) 
                    const CircularProgressIndicator()
                  else ...[
                    Text(
                      _description,
                      style: const TextStyle(color: Colors.grey, fontSize: 13, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    _buildStarRating(widget.eo.rating),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 30),

            // category
            if (!_isLoading && _categories.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: const Text('Category', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _categories.map((cat) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A5C91),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(cat, style: const TextStyle(color: Colors.white, fontSize: 12)),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 30),
            ],

            // package
            if (!_isLoading && _packages.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: const Text('Packages', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 12),
              
              ..._packages.take(2).map((pkg) {
                return Container(
                  height: 100,
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: widget.eo.image != null ? NetworkImage(widget.eo.image!) : const AssetImage('assets/images/ballroom.jpg') as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black.withValues(alpha: 0.8), Colors.transparent],
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      pkg.name,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }).toList(),

              // Tombol See All Packages
              if (_packages.length > 2)
                Padding(
                  padding: const EdgeInsets.only(right: 24, bottom: 30),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // Nanti diarahkan ke layar See All Packages
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('see all packages', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward, size: 14),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(size.width / 2, size.height + 20, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}