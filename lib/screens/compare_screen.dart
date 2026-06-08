import 'package:flutter/material.dart';
import '../models/event_organizer.dart';
import 'search_screen.dart';
import '../widgets/compare_column.dart';

class CompareScreen extends StatefulWidget {
  const CompareScreen({Key? key}) : super(key: key);

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  EventOrganizerModel? eo1;
  EventOrganizerModel? eo2;

  Future<void> _selectEo(int targetIndex) async {
    final selectedEo = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchScreen(isSelectionMode: true),
      ),
    );

    if (selectedEo != null && selectedEo is EventOrganizerModel) {
      setState(() {
        if (targetIndex == 1) eo1 = selectedEo;
        if (targetIndex == 2) eo2 = selectedEo;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF0D2546),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              image: DecorationImage(
                image: AssetImage('assets/images/ballroom.jpg'),
                fit: BoxFit.cover,
                opacity: 0.15,
              ),
            ),
          ),
          
          Expanded(
            child: Row(
              children: [
                // KOLOM KIRI (EO 1)
                Expanded(
                  child: eo1 == null
                      ? _buildEmptyState(() => _selectEo(1))
                      : CompareColumn(eo: eo1!, isComparing: eo2 != null),
                ),
                
                Container(width: 1, color: Colors.grey.shade300),
                
                // KOLOM KANAN (EO 2)
                Expanded(
                  child: eo2 == null
                      ? _buildEmptyState(() => _selectEo(2))
                      : CompareColumn(eo: eo2!, isComparing: eo1 != null),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(VoidCallback onAdd) {
    return Column(
      children: [
        const SizedBox(height: 40),
        const Divider(indent: 20, endIndent: 20),
        const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Details')),
        const Divider(indent: 20, endIndent: 20),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: onAdd,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade200,
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 40),
            ),
            child: const Text('Add'),
          ),
        ),
      ],
    );
  }
}