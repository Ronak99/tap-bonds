import 'package:flutter/material.dart';
import 'package:tap_bonds/shared/widgets/content_container.dart';

class TopLevelMetrics extends StatelessWidget {
  final String logo;
  final String name;
  final String description;
  final String isin;
  const TopLevelMetrics({
    super.key,
    required this.logo,
    required this.name,
    required this.description,
    required this.isin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          ContentContainer(
            height: 60,
            width: 60,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            borderRadius: BorderRadius.circular(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                logo,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xff101828),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Color(0xff6A7282),
              letterSpacing: .4,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color(0xff2563EB).withOpacity(.10),
                ),
                alignment: Alignment.center,
                child: Text(
                  'ISIN: $isin',
                  style: const TextStyle(
                    color: Color(0xff2563EB),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color(0xff059669).withOpacity(.06),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'ACTIVE',
                  style: TextStyle(
                    color: Color(0xff059669),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
