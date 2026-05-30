import 'package:flutter/material.dart';
import 'package:eo_app/models/event_organizer.dart';
import 'package:eo_app/screens/EOProfile_screen.dart';

class EOCard extends StatelessWidget {
  final EventOrganizer eo;

  const EOCard({super.key, required this.eo});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      final fontSize = (w * 0.09).clamp(11.0, 14.0);
      final arrowSize = (w * 0.06).clamp(9.0, 12.0);
      final labelPadV = (w * 0.045).clamp(6.0, 10.0);

      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProfilePage(eo: eo)),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFFFFF), Color(0xFFD8D7EC)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF102B53).withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      eo.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (ctx, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          color: const Color(0xFFD6E4F7),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF102B53),
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFFD6E4F7),
                        child: const Icon(
                          Icons.image_not_supported_rounded,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0, left: 0, right: 0,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.15),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: w * 0.08, vertical: labelPadV),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF102B53), Color(0xFF2A3A7C)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        eo.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.white70, size: arrowSize),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}import 'package:flutter/material.dart';
import 'package:eo_app/models/event_organizer.dart';
import 'package:eo_app/screens/EOProfile_screen.dart';

class EOCard extends StatelessWidget {
  final EventOrganizer eo;

  const EOCard({super.key, required this.eo});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      final fontSize = (w * 0.09).clamp(11.0, 14.0);
      final arrowSize = (w * 0.06).clamp(9.0, 12.0);
      final labelPadV = (w * 0.045).clamp(6.0, 10.0);

      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProfilePage(eo: eo)),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFFFFF), Color(0xFFD8D7EC)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF102B53).withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      eo.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (ctx, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          color: const Color(0xFFD6E4F7),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF102B53),
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFFD6E4F7),
                        child: const Icon(
                          Icons.image_not_supported_rounded,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0, left: 0, right: 0,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.15),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: w * 0.08, vertical: labelPadV),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF102B53), Color(0xFF2A3A7C)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        eo.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.white70, size: arrowSize),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}