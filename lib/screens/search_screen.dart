import 'package:flutter/material.dart';
import 'package:eo_app/models/event_organizer.dart';
import 'package:eo_app/services/eo_service.dart';
import 'package:eo_app/widgets/eo_card.dart';
import 'package:eo_app/widgets/bottom_nav_bar.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static const Color _navy = Color(0xFF102B53);
  static const Color _bgColor = Color(0xFFE6EAF3);

  int _selectedIndex = 0;
  String _selectedLocation = 'All Locations';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // TODO: Ganti dengan Future<List<EventOrganizer>> dari EOService.getEOs()
  // saat backend sudah siap, gunakan FutureBuilder
  late List<EventOrganizer> _allEOs;

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

  @override
  void initState() {
    super.initState();
    _allEOs = EOService.getEOs();
  }

  List<EventOrganizer> get _filteredEOs {
    return _allEOs.where((eo) {
      final matchSearch =
          eo.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchLocation = _selectedLocation == 'All Locations' ||
          eo.location == _selectedLocation;
      return matchSearch && matchLocation;
    }).toList();
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
                      child: _filteredEOs.isEmpty
                          ? const Center(
                              child: Text('No event organizers found.',
                                  style: TextStyle(color: Colors.grey)))
                          : GridView.builder(
                              padding: EdgeInsets.all(w * 0.04),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: w * 0.03,
                                mainAxisSpacing: w * 0.03,
                                childAspectRatio: 1.0,
                              ),
                              itemCount: _filteredEOs.length,
                              itemBuilder: (context, index) {
                                return EOCard(eo: _filteredEOs[index]);
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
          Expanded(
            flex: 3,
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
                style: const TextStyle(fontSize: 13),
                decoration: const InputDecoration(
                  hintText: 'search',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  prefixIcon:
                      Icon(Icons.search, color: Colors.grey, size: 20),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)),
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
                            child: Text(loc,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 11)),
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
}