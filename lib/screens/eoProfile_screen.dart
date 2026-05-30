import 'package:flutter/material.dart';
import 'package:eo_app/models/event_organizer.dart';
import 'package:eo_app/screens/package_screen.dart';      
import 'package:eo_app/widgets/bottom_nav_bar.dart';
import 'package:eo_app/widgets/package_preview_card.dart';

class ProfilePage extends StatefulWidget {
  final EventOrganizer eo;

  const ProfilePage({super.key, required this.eo});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const Color _navy = Color(0xFF102B53);
  static const Color _bgColor = Color(0xFFE6EAF3);

  int _selectedIndex = 0;

  // TODO: Ambil dari PackageService.getPreviewPackages(eo.id)
  final List<Map<String, String>> _previewPackages = [
    {
      'name': 'Birthday Party',
      'image':
          'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?w=600',
    },
    {
      'name': 'Gathering',
      'image':
          'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?w=600',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      final contentWidth = w > 600 ? 420.0 : w;

      return Scaffold(
        backgroundColor: _bgColor,
        body: Center(
          child: SizedBox(
            width: contentWidth,
            child: Container(
              decoration: const BoxDecoration(
                gradient: SweepGradient(
                  center: Alignment.topRight,
                  colors: [
                    Color(0xFFE6EAF3),
                    Color(0xFFA3A1C8),
                    Color(0xFFE6EAF3),
                    Color(0xFFA3A1C8),
                    Color(0xFFE6EAF3),
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    _buildTopBar(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildProfileCard(contentWidth),
                            _buildPackagesSection(),
                          ],
                        ),
                      ),
                    ),
                    AppBottomNavBar(
                      selectedIndex: _selectedIndex,
                      onTap: (i) => setState(() => _selectedIndex = i),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_navy, Color(0xFF1E4A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
              color: Color(0x66102B53), blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white30),
              ),
              child: const Icon(Icons.chevron_left_rounded,
                  color: Colors.white, size: 24),
            ),
          ),
          const Expanded(
            child: Text(
              'PROFILE',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(width: 38),
        ],
      ),
    );
  }

  Widget _buildProfileCard(double w) {
    final avatarSize = (w * 0.28).clamp(90.0, 120.0);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF102B53).withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _navy, width: 3),
              boxShadow: [
                BoxShadow(
                  color: _navy.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.network(
                widget.eo.profileImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFD6E4F7),
                  child: const Icon(Icons.person, size: 50, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.eo.name,
            style: TextStyle(
              color: _navy,
              fontSize: (w * 0.055).clamp(18.0, 24.0),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(height: 1.5, width: 140, color: const Color(0x4D102B53)),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (i) => Icon(Icons.star_rounded,
                  color: const Color(0xFFFFC107),
                  size: (w * 0.075).clamp(24.0, 32.0)),
            ),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            // TODO: Navigasi ke halaman Reviews dari backend
            // onTap: () => Navigator.push(context, MaterialPageRoute(
            //   builder: (_) => ReviewsPage(eoId: widget.eo.id))),
            onTap: () {},
            child: const Text(
              'see reviews',
              style: TextStyle(
                color: Color(0xFF102B53),
                fontSize: 12,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackagesSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Packages',
            style: TextStyle(
              color: Color(0xFF102B53),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ..._previewPackages.map((pkg) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: PackagePreviewCard(
                  name: pkg['name']!,
                  imageUrl: pkg['image']!,
                ),
              )),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PackagePage()),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'see all packages',
                    style: TextStyle(
                      color: Color(0xFF102B53),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_rounded,
                      color: Color(0xFF102B53), size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}