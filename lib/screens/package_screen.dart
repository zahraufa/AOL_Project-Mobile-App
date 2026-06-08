import 'package:flutter/material.dart';
import '../models/event_organizer.dart';
import '../models/package_model.dart';
// import 'package_detail_screen.dart'; // Buka komen ini jika halaman detail sudah dibuat
// import 'payment_screen.dart'; // Buka komen ini jika halaman payment sudah dibuat

class EoPackagesScreen extends StatefulWidget {
  final EventOrganizerModel eo;
  final List<PackageModel> packages;

  const EoPackagesScreen({Key? key, required this.eo, required this.packages}) : super(key: key);

  @override
  State<EoPackagesScreen> createState() => _EoPackagesScreenState();
}

class _EoPackagesScreenState extends State<EoPackagesScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  List<PackageModel> _filteredPackages = [];
  String _selectedSort = 'Lowest Price';
  final List<String> _sortOptions = ['Lowest Price', 'Highest Price'];

  @override
  void initState() {
    super.initState();
    _filteredPackages = List.from(widget.packages);
    _applyFilterAndSort();
  }

  void _applyFilterAndSort() {
    List<PackageModel> temp = widget.packages.where((pkg) {
      return pkg.name.toLowerCase().contains(_searchController.text.toLowerCase());
    }).toList();

    if (_selectedSort == 'Lowest Price') {
      temp.sort((a, b) => a.price.compareTo(b.price));
    } else {
      temp.sort((a, b) => b.price.compareTo(a.price));
    }

    setState(() {
      _filteredPackages = temp;
    });
  }

  String _formatPrice(double price) {
    String priceStr = price.toInt().toString();
    priceStr = priceStr.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
    return 'Rp$priceStr';
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
          // header
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
                              'PACKAGES',
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Search & Sort Bar
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
                                  onChanged: (value) => _applyFilterAndSort(),
                                  decoration: const InputDecoration(
                                    hintText: 'search',
                                    hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                              const Icon(Icons.search, color: Colors.grey, size: 18),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Sort Dropdown
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
                              value: _selectedSort,
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                              style: const TextStyle(color: Colors.grey, fontSize: 11),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _selectedSort = newValue;
                                  });
                                  _applyFilterAndSort();
                                }
                              },
                              items: _sortOptions.map<DropdownMenuItem<String>>((String value) {
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

          // list
          Expanded(
            child: _filteredPackages.isEmpty
                ? const Center(child: Text('Package tidak ditemukan', style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    itemCount: _filteredPackages.length,
                    itemBuilder: (context, index) {
                      final pkg = _filteredPackages[index];
                      
                      return Container(
                        height: 120,
                        margin: const EdgeInsets.only(bottom: 16),
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
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [Colors.black.withValues(alpha: 0.7), Colors.black.withValues(alpha: 0.9)],
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      pkg.name,
                                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    _formatPrice(pkg.price),
                                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              
                              const Spacer(),
                              
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // See Details
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      minimumSize: const Size(80, 28),
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                    ),
                                    onPressed: () {
                                      // Navigator.push(context, MaterialPageRoute(builder: (_) => PackageDetailScreen(package: pkg)));
                                    },
                                    child: const Text('See Details', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(width: 10),
                                  // Book Now
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      minimumSize: const Size(80, 28),
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                    ),
                                    onPressed: () {
                                      // Navigator.push(context, MaterialPageRoute(builder: (_) => PaymentScreen(package: pkg, eo: widget.eo)));
                                    },
                                    child: const Text('Book Now', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}