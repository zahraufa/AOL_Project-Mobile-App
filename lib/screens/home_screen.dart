import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/event_organizer.dart';
import '../models/package_model.dart';
import '../services/api_services.dart';
import 'search_screen.dart';
import 'EOProfile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiServices _apiServices = ApiServices();

  String _username = 'Guest';

  bool _isLoading = true;
  List<EventOrganizerModel> _recommendedEos = [];
  
  List<Map<String, dynamic>> _popularPackages = []; 

  @override
  void initState() {
    super.initState();
    _fetchHomeData();
    _loadUsername();
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(!mounted) return;
    setState(() {
      _username = prefs.getString('username') ?? 'Guest';
    });
  }

  Future<void> _fetchHomeData() async {
    final allEos = await _apiServices.getEventOrganizers();
    
    if (allEos.isNotEmpty) {
      _recommendedEos = allEos.where((eo) => eo.rating >= 4.8).toList();

      List<Map<String, dynamic>> tempPackages = [];
      int loopCount = _recommendedEos.length > 3 ? 3 : _recommendedEos.length;
      
      for (int i = 0; i < loopCount; i++) {
        final eo = _recommendedEos[i];
        final details = await _apiServices.getEoDetails(eo.id);
        
        if (details != null) {
          final rawPackages = details['packages'] as List<dynamic>? ?? 
                              details['eo_package'] as List<dynamic>? ?? [];
                              
          if (rawPackages.isNotEmpty) {
            final pkg = PackageModel.fromJson(rawPackages[0]);
            tempPackages.add({
              'eo_name': eo.name,
              'eo_image': eo.image,
              'package': pkg,
            });
          }
        }
      }
      _popularPackages = tempPackages;
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // header
                SizedBox(
                  height: 200, 
                  child: Stack(
                    children: [
                      Container(
                        height: 175,
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
                            opacity: 0.2,
                          ),
                        ),
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.person, size: 40, color: Color(0xFF0D2546)),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Welcome!', style: TextStyle(color: Colors.white70, fontSize: 14)),
                                    Text(
                                      _username,
                                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Search Bar
                      Positioned(
                        bottom: 0,
                        left: 24,
                        right: 24,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SearchScreen()),
                            );
                          },
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
                            ),
                            child: Row(
                              children: const [
                                Expanded(
                                  child: Text('search', style: TextStyle(color: Colors.grey, fontSize: 14)),
                                ),
                                Icon(Icons.search, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // rekomen eo
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Recommended\nEvent Organizers',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1.2),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 120,
                  child: _recommendedEos.isEmpty
                      ? const Center(child: Text('Belum ada EO dengan rating 5', style: TextStyle(color: Colors.grey)))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          scrollDirection: Axis.horizontal,
                          itemCount: _recommendedEos.length,
                          itemBuilder: (context, index) {
                            final eo = _recommendedEos[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => EoProfileScreen(eo: eo)));
                              },
                              child: Container(
                                width: 110,
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: eo.image != null ? NetworkImage(eo.image!) : const AssetImage('assets/images/ballroom.jpg') as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.star, color: Colors.amber, size: 12),
                                        const SizedBox(width: 2),
                                        Text(eo.rating.toString(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),

                const SizedBox(height: 24),

                // popular packages
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Popular Packages',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: _popularPackages.isEmpty
                      ? const Center(child: Text('Belum ada paket populer', style: TextStyle(color: Colors.grey)))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          scrollDirection: Axis.horizontal,
                          itemCount: _popularPackages.length,
                          itemBuilder: (context, index) {
                            final item = _popularPackages[index];
                            final pkg = item['package'] as PackageModel;
                            
                            return Container(
                              width: 150,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: item['eo_image'] != null 
                                      ? NetworkImage(item['eo_image']) 
                                      : const AssetImage('assets/images/ballroom.jpg') as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [Colors.black.withValues(alpha: 0.9), Colors.transparent],
                                  ),
                                ),
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['eo_name'],
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                      maxLines: 1, overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      pkg.name,
                                      style: const TextStyle(color: Colors.white70, fontSize: 10),
                                      maxLines: 2, overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
    );
  }
}