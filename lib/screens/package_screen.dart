import 'package:flutter/material.dart';
import 'package:eo_app/models/package_model.dart';
import 'package:eo_app/services/package_service.dart';
import 'package:eo_app/widgets/package_card.dart';
import 'package:eo_app/widgets/bottom_nav_bar.dart';

class PackagePage extends StatefulWidget {
  const PackagePage({super.key});

  @override
  State<PackagePage> createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  static const Color _navy = Color(0xFF102B53);
  static const Color _bgColor = Color(0xFFE6EAF3);

  int _selectedIndex = 0;
  String _sortByEvent = 'All Events';
  String _sortByPrice = 'Default';

  // TODO: Ganti dengan Future<List<PackageModel>> dari PackageService.getPackages()
  late List<PackageModel> _allPackages;

  final List<String> _eventTypes = [
    'All Events', 'Birthday Party', 'Wedding',
    'Corporate Event', 'Baby Shower', 'Anniversary',
  ];
  final List<String> _priceOptions = [
    'Default', 'Lowest First', 'Highest First',
  ];

  @override
  void initState() {
    super.initState();
    _allPackages = PackageService.getPackages();
  }

  List<PackageModel> get _sortedPackages {
    List<PackageModel> list = _allPackages.where((p) {
      return _sortByEvent == 'All Events' || p.eventType == _sortByEvent;
    }).toList();
    if (_sortByPrice == 'Lowest First') {
      list.sort((a, b) => a.priceValue - b.priceValue);
    } else if (_sortByPrice == 'Highest First') {
      list.sort((a, b) => b.priceValue - a.priceValue);
    }
    return list;
  }

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
                    _buildTopBar(w),
                    Expanded(
                      child: _sortedPackages.isEmpty
                          ? const Center(
                              child: Text('No packages found.',
                                  style: TextStyle(color: Colors.grey)))
                          : ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 0.04, vertical: 14),
                              itemCount: _sortedPackages.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 14),
                                  child: PackageCard(
                                    package: _sortedPackages[index],
                                    screenWidth: contentWidth,
                                  ),
                                );
                              },
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

  Widget _buildTopBar(double w) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: 12),
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
              height: 42, width: 42,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 18),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _DropdownPill(
              value: _sortByEvent,
              items: _eventTypes,
              onChanged: (v) => setState(() => _sortByEvent = v!),
            ),
          ),
          const SizedBox(width: 8),
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
}

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