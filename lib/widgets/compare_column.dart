import 'package:flutter/material.dart';
import '../models/event_organizer.dart';
import '../models/package_model.dart';
import '../models/service_model.dart';
import '../services/api_services.dart';
import 'package:eo_app/screens/payment_screen.dart';

class CompareColumn extends StatefulWidget {
  final EventOrganizerModel eo;
  final bool isComparing;

  const CompareColumn({Key? key, required this.eo, required this.isComparing}) : super(key: key);

  @override
  State<CompareColumn> createState() => _CompareColumnState();
}

class _CompareColumnState extends State<CompareColumn> {
  final ApiServices _apiServices = ApiServices();
  
  bool _isLoading = true;
  List<PackageModel> packages = [];
  List<ServiceModel> addOns = [];
  
  PackageModel? selectedPackage;
  List<int> selectedAddOnIds = [];

  @override
  void initState() {
    super.initState();
    _fetchEoDetails();
  }

  Future<void> _fetchEoDetails() async {
    final data = await _apiServices.getEoDetails(widget.eo.id);
    if (data != null && mounted) {
      print('Respon JSON untuk EO ID ${widget.eo.id}: $data');
      final rawPackages = data['packages'] as List<dynamic>? ?? 
                          data['eo_package'] as List<dynamic>? ?? 
                          [];
      final rawServices = data['add_ons'] as List<dynamic>? ?? 
                          data['event_organizer_services'] as List<dynamic>? ?? 
                          [];

      setState(() {
        packages = rawPackages.map((p) => PackageModel.fromJson(p)).toList();
        addOns = rawServices.map((s) => ServiceModel.fromJson(s)).toList();
        
        if (packages.isNotEmpty) {
          packages.sort((a, b) => a.price.compareTo(b.price));
          selectedPackage = packages.first;
        }
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    return Column(
      children: [
        const SizedBox(height: 20),
        // FOTO & NAMA EO
        CircleAvatar(
          radius: 40,
          backgroundImage: widget.eo.image != null ? NetworkImage(widget.eo.image!) : null,
          child: widget.eo.image == null ? const Icon(Icons.business) : null,
        ),
        const SizedBox(height: 8),
        Text(widget.eo.name, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        const SizedBox(height: 10),

        if (selectedPackage != null) ...[
          Text(
            selectedPackage!.name,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),

        // DROPDOWN PACKAGE
        const Text('Price', style: TextStyle(fontSize: 10, color: Colors.grey)),
        if (packages.isNotEmpty)
          Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<PackageModel>(
                value: selectedPackage,
                icon: const Icon(Icons.arrow_drop_down, size: 16, color: Colors.grey),
                style: const TextStyle(fontSize: 11, color: Colors.black87),
                onChanged: (PackageModel? newValue) {
  
                  setState(() {
                    selectedPackage = newValue;
                  });
                },
                items: packages.map((pkg) => DropdownMenuItem(
                  value: pkg,
                  child: Text('Rp ${pkg.price.toInt()}'), 
                )).toList(),
              ),
            ),
          ),
        ] else ...[
          const Text('No packages available', style: TextStyle(fontSize: 10, color: Colors.grey)),
        ],

        const SizedBox(height: 12),
        const Divider(height: 1, thickness: 1),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text('Details', style: TextStyle(fontSize: 12)),
        ),
        const Divider(height: 1, thickness: 1),

        // PACKAGE DETAILS
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (selectedPackage != null) ...[
                  Text(
                    selectedPackage!.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedPackage!.description,
                    style: const TextStyle(fontSize: 10, color: Colors.grey, height: 1.4),
                    textAlign: TextAlign.center,
                  ),
                ],
                
                const SizedBox(height: 20),
                const Text('add ons', style: TextStyle(fontSize: 12)),
                const SizedBox(height: 10),

                // CHECKBOX ADD-ONS
                ...addOns.map((addon) {
                  return Row(
                    children: [
                      SizedBox(
                        height: 24, width: 24,
                        child: Checkbox(
                          value: selectedAddOnIds.contains(addon.id),
                          onChanged: (bool? val) {
                            setState(() {
                              if (val == true) {
                                selectedAddOnIds.add(addon.id);
                              } else {
                                selectedAddOnIds.remove(addon.id);
                              }
                            });
                          },
                        ),
                      ),
                      Expanded(child: Text(addon.name, style: const TextStyle(fontSize: 11), overflow: TextOverflow.ellipsis)),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        ),

        // Add / Choose This
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: widget.isComparing
              ? ElevatedButton(
                  onPressed: () {
                    if (selectedPackage != null) {
                      List<ServiceModel> checkedAddOns = addOns.where((addon) => selectedAddOnIds.contains(addon.id)).toList();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(
                            eo: widget.eo,
                            package: selectedPackage!,
                            addOns: checkedAddOns,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D2546), foregroundColor: Colors.white),
                  child: const Text('Choose this', style: TextStyle(fontSize: 12)),
                )
              : ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade200, foregroundColor: Colors.black),
                  child: const Text('Add', style: TextStyle(fontSize: 12)),
                ),
        ),
      ],
    );
  }
}