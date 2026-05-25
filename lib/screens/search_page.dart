import 'package:flutter/material.dart';
import 'profile_page.dart';
 
// ─── Data Model ───────────────────────────────────────────────────────────────
 
class EventOrganizer {
  final String name;
  final String imageUrl;
  final String location;
 
  const EventOrganizer({
    required this.name,
    required this.imageUrl,
    required this.location,
  });
}
 
final List<EventOrganizer> dummyEOs = [
  EventOrganizer(
    name: "Grand Ballroom EO",
    imageUrl: "https://images.unsplash.com/photo-1519167758481-83f550bb49b3?w=400",
    location: "Jakarta Selatan",
  ),
  EventOrganizer(
    name: "Royal Events Co.",
    imageUrl: "https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=400",
    location: "Jakarta Pusat",
  ),
  EventOrganizer(
    name: "Luxe Venue Studio",
    imageUrl: "https://images.unsplash.com/photo-1505236858219-8359eb29e329?w=400",
    location: "Jakarta Barat",
  ),
  EventOrganizer(
    name: "Dream Wedding EO",
    imageUrl: "https://images.unsplash.com/photo-1519741497674-611481863552?w=400",
    location: "Tangerang",
  ),
  EventOrganizer(
    name: "Elegant Spaces",
    imageUrl: "https://images.unsplash.com/photo-1478146896981-b80fe463b330?w=400",
    location: "Bekasi",
  ),
  EventOrganizer(
    name: "Premier Hall EO",
    imageUrl: "https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=400",
    location: "Depok",
  ),
  EventOrganizer(
    name: "Gala Events Pro",
    imageUrl: "https://images.unsplash.com/photo-1561489413-985b06da5bee?w=400",
    location: "Jakarta Timur",
  ),
  EventOrganizer(
    name: "Majestic Venue EO",
    imageUrl: "https://images.unsplash.com/photo-1510076857177-7470076d4098?w=400",
    location: "Bogor",
  ),
];
 
// ─── Search Page ──────────────────────────────────────────────────────────────
 
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
 
  @override
  State<SearchPage> createState() => _SearchPageState();
}
 
class _SearchPageState extends State<SearchPage> {
  int _selectedIndex = 0;
  String _selectedLocation = 'All Locations';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
 
  static const Color _navyBlue      = Color(0xFF102B53);
  static const Color _bgColor       = Color(0xFFE6EAF3);
  static const Color _gradientAccent = Color(0xFFA3A1C8);
 
  final List<String> _locations = [
    'All Locations',
    'Jakarta Selatan',
    'Jakarta Pusat',
    'Jakarta Barat',
    'Jakarta Timur',
    'Tangerang',
    'Bekasi',
    'Depok',
    'Bogor',
  ];
 
  List<EventOrganizer> get _filteredEOs {
    return dummyEOs.where((eo) {
      final matchSearch =
          eo.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchLocation =
          _selectedLocation == 'All Locations' ||
          eo.location == _selectedLocation;
      return matchSearch && matchLocation;
    }).toList();
  }
 
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
                  _buildTopBar(),
                  Expanded(
                    child: _filteredEOs.isEmpty
                        ? const Center(
                            child: Text(
                              'No event organizers found.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                              childAspectRatio: 1.0,
                            ),
                            itemCount: _filteredEOs.length,
                            itemBuilder: (context, index) {
                              return _EOCard(eo: _filteredEOs[index]);
                            },
                          ),
                  ),
                  _buildBottomNav(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
 
  // ── Top Search + Sort Bar ─────────────────────────────────────────────────
 
  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_navyBlue, Color(0xFF1E4A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: _navyBlue.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Search Field
          Expanded(
            flex: 3,
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
                style: const TextStyle(fontSize: 13),
                decoration: const InputDecoration(
                  hintText: 'search',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Sort by Location Dropdown
          Expanded(
            flex: 2,
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedLocation,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down,
                      color: Colors.grey, size: 18),
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 11,
                      fontFamily: 'Roboto'),
                  items: _locations
                      .map((loc) => DropdownMenuItem(
                            value: loc,
                            child: Text(
                              loc,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 11),
                            ),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedLocation = val);
                  },
                ),
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
      decoration: BoxDecoration(
        color: _navyBlue,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final isSelected = _selectedIndex == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedIndex = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: isSelected
                  ? BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    )
                  : null,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    items[i].icon,
                    color: isSelected ? Colors.white : Colors.white60,
                    size: isSelected ? 26 : 22,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    items[i].label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white60,
                      fontSize: 10,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
 
// ─── EO Card Widget ───────────────────────────────────────────────────────────
 
class _EOCard extends StatelessWidget {
  final EventOrganizer eo;
 
  const _EOCard({required this.eo});
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProfilePage(
              eoName: eo.name,
              eoImageUrl: eo.imageUrl,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFD8D7EC),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF102B53).withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    eo.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (ctx, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: const Color(0xFFD6E4F7),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF102B53),
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (ctx, err, stack) => Container(
                      color: const Color(0xFFD6E4F7),
                      child: const Icon(
                        Icons.image_not_supported_rounded,
                        color: Colors.grey,
                        size: 40,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0, left: 0, right: 0,
                    height: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.15),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Name Label
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF102B53), Color(0xFF2A3A7C)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      eo.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.white70, size: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 
// ─── Helper Classes ───────────────────────────────────────────────────────────
 
class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}