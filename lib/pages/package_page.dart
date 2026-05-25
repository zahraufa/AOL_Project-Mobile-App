import 'package:flutter/material.dart';

// ─── Data Model ───────────────────────────────────────────────────────────────

class PackageModel {
  final String eventType;
  final String price;
  final List<String> includes;
  final String imageUrl;

  const PackageModel({
    required this.eventType,
    required this.price,
    required this.includes,
    required this.imageUrl,
  });
}

final List<PackageModel> dummyPackages = [
  PackageModel(
    eventType: "Birthday Party",
    price: "Rp5.000.000",
    includes: ["Room", "MUA", "Photographer", "Decoration"],
    imageUrl: "https://images.unsplash.com/photo-1530103862676-de8c9debad1d?w=600",
  ),
  PackageModel(
    eventType: "Wedding",
    price: "Rp15.000.000",
    includes: ["Room", "MUA", "Photographer", "Decoration", "Catering"],
    imageUrl: "https://images.unsplash.com/photo-1519741497674-611481863552?w=600",
  ),
  PackageModel(
    eventType: "Corporate Event",
    price: "Rp8.000.000",
    includes: ["Room", "Sound System", "Photographer", "Decoration"],
    imageUrl: "https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=600",
  ),
  PackageModel(
    eventType: "Baby Shower",
    price: "Rp3.500.000",
    includes: ["Room", "MUA", "Photographer", "Decoration"],
    imageUrl: "https://images.unsplash.com/photo-1519167758481-83f550bb49b3?w=600",
  ),
  PackageModel(
    eventType: "Anniversary",
    price: "Rp6.000.000",
    includes: ["Room", "MUA", "Photographer", "Decoration", "Cake"],
    imageUrl: "https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=600",
  ),
];

// ─── Package Page ─────────────────────────────────────────────────────────────

class PackagePage extends StatefulWidget {
  const PackagePage({super.key});

  @override
  State<PackagePage> createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  static const Color _navy   = Color(0xFF102B53);
  static const Color _bgColor = Color(0xFFE6EAF3);

  int _selectedIndex = 0;
  String _sortByEvent = 'All Events';
  String _sortByPrice = 'Default';

  final List<String> _eventTypes = [
    'All Events', 'Birthday Party', 'Wedding',
    'Corporate Event', 'Baby Shower', 'Anniversary',
  ];
  final List<String> _priceOptions = [
    'Default', 'Lowest First', 'Highest First',
  ];

  List<PackageModel> get _sortedPackages {
    List<PackageModel> list = dummyPackages.where((p) {
      return _sortByEvent == 'All Events' || p.eventType == _sortByEvent;
    }).toList();

    if (_sortByPrice == 'Lowest First') {
      list.sort((a, b) => _parsePrice(a.price) - _parsePrice(b.price));
    } else if (_sortByPrice == 'Highest First') {
      list.sort((a, b) => _parsePrice(b.price) - _parsePrice(a.price));
    }
    return list;
  }

  int _parsePrice(String price) {
    return int.tryParse(
        price.replaceAll('Rp', '').replaceAll('.', '').trim()) ?? 0;
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
                    child: _sortedPackages.isEmpty
                        ? const Center(
                            child: Text('No packages found.',
                                style: TextStyle(color: Colors.grey)))
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            itemCount: _sortedPackages.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: _PackageCard(
                                    package: _sortedPackages[index]),
                              );
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

  // ── Top Bar ────────────────────────────────────────────────────────────────

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
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
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 18),
            ),
          ),
          const SizedBox(width: 8),
          // Sort by Event
          Expanded(
            child: _DropdownPill(
              value: _sortByEvent,
              items: _eventTypes,
              onChanged: (v) => setState(() => _sortByEvent = v!),
            ),
          ),
          const SizedBox(width: 8),
          // Sort by Price
          Expanded(
            child: _DropdownPill(
              value: _sortByPrice,
              items: _priceOptions,
              onChanged: (v) => setState(() => _sortByPrice = v!),
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
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
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

// ─── Package Card ─────────────────────────────────────────────────────────────

class _PackageCard extends StatelessWidget {
  final PackageModel package;

  const _PackageCard({required this.package});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF102B53).withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.network(
            package.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(color: const Color(0xFF1E3A5F)),
          ),
          // Dark overlay gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  const Color(0xFF102B53).withOpacity(0.92),
                  const Color(0xFF102B53).withOpacity(0.55),
                ],
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      package.eventType,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      package.price,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Includes:',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bullet list
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: package.includes
                              .take(4)
                              .map((item) => Padding(
                                    padding: const EdgeInsets.only(bottom: 1),
                                    child: Row(
                                      children: [
                                        const Text('• ',
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 11)),
                                        Text(item,
                                            style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 11)),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      // Book Now button
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 7),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Text(
                              'book now',
                              style: TextStyle(
                                color: Color(0xFF102B53),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

class _DropdownPill extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropdownPill({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey, size: 18),
          style: const TextStyle(
              color: Colors.black87, fontSize: 11, fontFamily: 'Roboto'),
          items: items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 11)),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}