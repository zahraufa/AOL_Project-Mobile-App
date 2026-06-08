import 'package:flutter/material.dart';
import '../models/event_organizer.dart';
import '../services/api_services.dart';
import '../widgets/eo_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiServices _apiServices = ApiServices();
  List<EventOrganizerModel> _eoList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final data = await _apiServices.getEventOrganizers();
    setState(() {
      _eoList = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
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
                child: const SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      'eo search',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              // search dan sort button
              Positioned(
                bottom: -20,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    // Search
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
                        ),
                        child: Row(
                          children: const [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'search',
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Icon(Icons.search, color: Colors.grey, size: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // sort
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'sort by category',
                              style: TextStyle(color: Colors.grey, fontSize: 10),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Icon(Icons.arrow_drop_down, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 35),

          // eo cards
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
                              // Nanti ganti dengan navigasi ke halaman profile EO
                              print('Click EO: ${eo.name}');
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