import 'package:flutter/material.dart';
import '../models/event_organizer.dart';
import '../models/package_model.dart';
import '../models/service_model.dart';
import '../services/api_services.dart';

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
      final rawPackages = data['package'] as List<dynamic>? ?? [];
      final rawServices = data['add_ons'] as List<dynamic>? ?? [];

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

        // DROPDOWN PACKAGE
        const Text('Package', style: TextStyle(fontSize: 10, color: Colors.grey)),
        if (packages.isNotEmpty)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<PackageModel>(
                isExpanded: true,
                value: selectedPackage,
                style: const TextStyle(fontSize: 12, color: Colors.black),
                onChanged: (val) => setState(() => selectedPackage = val),
                items: packages.map((pkg) => DropdownMenuItem(
                  value: pkg,
                  child: Text(pkg.name),
                )).toList(),
              ),
            ),
          ),

        const Divider(),
        const Text('Details', style: TextStyle(fontSize: 12)),
        const Divider(),

        // PACKAGE DETAILS
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (selectedPackage != null) ...[
                  Text(selectedPackage!.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(selectedPackage!.description, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                ],
                
                const SizedBox(height: 16),
                const Center(child: Text('add ons', style: TextStyle(fontSize: 12))),
                const SizedBox(height: 8),

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