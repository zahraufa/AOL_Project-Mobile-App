import 'package:flutter/material.dart';

class PackagePreviewCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  const PackagePreviewCard({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      final h = (w * 0.28).clamp(90.0, 110.0);
      final fontSize = (w * 0.042).clamp(13.0, 16.0);

      return Container(
        height: h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF102B53).withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
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
                    const Color(0xFF102B53).withOpacity(0.75),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned(
              left: w * 0.04,
              bottom: h * 0.15,
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}