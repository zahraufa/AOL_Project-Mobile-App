import 'package:flutter/material.dart';
import 'package:eo_app/models/package_model.dart';

class PackageCard extends StatelessWidget {
  final PackageModel package;
  final double screenWidth;

  const PackageCard({
    super.key,
    required this.package,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final cardHeight = (screenWidth * 0.38).clamp(130.0, 160.0);

    return Container(
      height: cardHeight,
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
          Image.network(
            package.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(color: const Color(0xFF1E3A5F)),
          ),
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
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      package.eventType,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: (screenWidth * 0.042).clamp(14.0, 17.0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      package.price,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: (screenWidth * 0.032).clamp(11.0, 14.0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Includes:',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: package.includes
                              .take(4)
                              .map((item) => Padding(
                                    padding: const EdgeInsets.only(bottom: 1),
                                    child: Row(children: [
                                      const Text('- ',
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 11)),
                                      Text(item,
                                          style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 11)),
                                    ]),
                                  ))
                              .toList(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          // TODO: Hubungkan ke backend untuk proses booking
                          // onTap: () => BookingService.bookPackage(package.id, userId),
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