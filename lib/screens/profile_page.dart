import 'package:flutter/material.dart';
import 'package_screen.dart';
 
// ─── Profile Page ─────────────────────────────────────────────────────────────
 
class ProfilePage extends StatefulWidget {
  final String eoName;
  final String eoImageUrl;
 
  const ProfilePage({
    super.key,
    required this.eoName,
    required this.eoImageUrl,
  });
 
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
 
class _ProfilePageState extends State<ProfilePage> {
  static const Color _navy    = Color(0xFF102B53);
  static const Color _bgColor = Color(0xFFE6EAF3);
 
  String _selectedDate = 'Available dates';
  int _selectedIndex   = 0;
 
  final List<String> _availableDates = [
    'Available dates',
    'June 2025',
    'July 2025',
    'August 2025',
    'September 2025',
  ];
 
  // Preview packages shown on profile
  final List<Map<String, String>> _previewPackages = [
    {
      'name': 'Birthday Party',
      'image': 'https://images.unsplash.com/photo-1530103862676-de8c9debad1d?w=600',
    },
    {
      'name': 'Gathering',
      'image': 'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=600',
    },
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
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
                  // ── Top Bar ──
                  _buildTopBar(),
 
                  // ── Body ──
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // ── Profile Card ──
                          _buildProfileCard(),
 
                          // ── Packages Section ──
                          _buildPackagesSection(),
                        ],
                      ),
                    ),
                  ),
 
                  // ── Bottom Nav ──
                  _buildBottomNav(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
 
  // ── Top Bar ────────────────────────────────────────────────────────────────
 
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
            color: Color(0x66102B53),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white30),
              ),
              child: const Icon(Icons.chevron_left_rounded,
                  color: Colors.white, size: 24),
            ),
          ),
          // Title
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
          // Spacer to balance back button
          const SizedBox(width: 38),
        ],
      ),
    );
  }
 
  // ── Profile Card ───────────────────────────────────────────────────────────
 
  Widget _buildProfileCard() {
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
          // ── Avatar ──
          Container(
            width: 110,
            height: 110,
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
                widget.eoImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFD6E4F7),
                  child: const Icon(Icons.person, size: 50, color: Colors.grey),
                ),
              ),
            ),
          ),
 
          const SizedBox(height: 16),
 
          // ── Name ──
          Text(
            widget.eoName,
            style: const TextStyle(
              color: Color(0xFF102B53),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
 
          const SizedBox(height: 8),
 
          // ── Divider ──
          Container(
            height: 1.5,
            width: 140,
            color: const Color(0xFF102B53).withOpacity(0.3),
          ),
 
          const SizedBox(height: 14),
 
          // ── Star Rating ──
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (i) => const Icon(Icons.star_rounded,
                  color: Color(0xFFFFC107), size: 30),
            ),
          ),
 
          const SizedBox(height: 6),
 
          // ── See Reviews ──
          GestureDetector(
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
 
          const SizedBox(height: 16),
 
          // ── Available Dates Dropdown ──
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
            decoration: BoxDecoration(
              color: _navy,
              borderRadius: BorderRadius.circular(30),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedDate,
                dropdownColor: _navy,
                icon: const Icon(Icons.arrow_drop_down,
                    color: Colors.white, size: 20),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: 'Roboto'),
                items: _availableDates
                    .map((d) => DropdownMenuItem(
                          value: d,
                          child: Text(d,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 13)),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedDate = val);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
 
  // ── Packages Section ───────────────────────────────────────────────────────
 
  Widget _buildPackagesSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          const Text(
            'Packages',
            style: TextStyle(
              color: Color(0xFF102B53),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
 
          // Package preview cards
          ..._previewPackages.map((pkg) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _PackagePreviewCard(
                  name: pkg['name']!,
                  imageUrl: pkg['image']!,
                ),
              )),
 
          // See all packages
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PackagePage()),
                );
              },
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
 
  // ── Bottom Navigation Bar ─────────────────────────────────────────────────
 
  Widget _buildBottomNav() {
    final items = [
      _NavItem(icon: Icons.home_rounded,          label: 'Home'),
      _NavItem(icon: Icons.search_rounded,         label: 'Search'),
      _NavItem(icon: Icons.compare_arrows_rounded, label: 'Compare'),
      _NavItem(icon: Icons.chat_bubble_rounded,    label: 'Chat'),
      _NavItem(icon: Icons.person_rounded,         label: 'Profile'),
    ];
 
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: _navy,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, -4)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final selected = _selectedIndex == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedIndex = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: selected
                  ? BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    )
                  : null,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(items[i].icon,
                      color: selected ? Colors.white : Colors.white60,
                      size: selected ? 26 : 22),
                  const SizedBox(height: 3),
                  Text(items[i].label,
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.white60,
                        fontSize: 10,
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.normal,
                      )),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
 
// ─── Package Preview Card ─────────────────────────────────────────────────────
 
class _PackagePreviewCard extends StatelessWidget {
  final String name;
  final String imageUrl;
 
  const _PackagePreviewCard({required this.name, required this.imageUrl});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF102B53).withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(color: const Color(0xFF1E3A5F)),
          ),
          // Dark overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  const Color(0xFF102B53).withOpacity(0.75),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // Label
          Positioned(
            left: 14,
            bottom: 14,
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 
// ─── Helper ───────────────────────────────────────────────────────────────────
 
class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}
