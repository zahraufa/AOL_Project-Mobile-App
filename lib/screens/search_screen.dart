import 'package:flutter/material.dart';
import '../models/event_organizer.dart';
import '../services/api_services.dart';
import '../widgets/eo_card.dart';
//import 'eo_profile_screen.dart';

class SearchScreen extends StatefulWidget {
  final bool isSelectionMode;
  const SearchScreen({Key? key, this.isSelectionMode = false}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiServices _apiServices = ApiServices();
  List<EventOrganizerModel> _eoList = [];
  bool _isLoading = true;

  final TextEditingController _searchController = TextEditingController();
  final List<String> _categories = [
    'all category',
    'Wedding Event',
    'Corporate Event',
    'Birthday Party',
    'Seminar'
  ];

  String _selectedCategory = 'all category';

  @override
  void initState() {
    super.initState();
    _fetchEoData();
  }

  Future<void> _fetchEoData({String? category}) async {
    setState(() => _isLoading = true);
    final data = await _apiServices.getEventOrganizers(category: category);
    
    if (!mounted) return;
    setState(() {
      _eoList = data;
      _isLoading = false;
    });
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 160,
            child: Stack(
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0D2546),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/images/ballroom.jpg'),
                      fit: BoxFit.cover,
                      opacity: 0.3,
                    ),
                  ),
                ),

                // SEARCH & DROPDOWN BAR
                Positioned(
                  bottom: 0,
                  left: 20,
                  right: 20,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  decoration: const InputDecoration(
                                    hintText: 'search',
                                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                              const Icon(Icons.search, color: Colors.grey, size: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      
                      // dropdown
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedCategory,
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                              style: const TextStyle(color: Colors.grey, fontSize: 11),
                              onChanged: (String? newValue) {
                                if (newValue != null){
                                  setState(() {
                                    _selectedCategory = newValue;
                                  });
                                  _fetchEoData(category: newValue);
                                }
                              },
                              items: _categories.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
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
          
          const SizedBox(height: 15),

          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _eoList.isEmpty
                    ? const Center(child: Text('No EO'))
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, 
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.85, 
                        ),
                        itemCount: _eoList.length,
                        itemBuilder: (context, index) {
                          final eo = _eoList[index];
                          return EoCard(
                            eo: eo,
                            onTap: () {
                              if (widget.isSelectionMode) {
                                Navigator.pop(context, eo);
                              } else {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => EoProfileScreen(eo: eo)),
                                // );
                              }
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}