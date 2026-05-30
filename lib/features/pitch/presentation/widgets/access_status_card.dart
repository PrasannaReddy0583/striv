import 'package:flutter/material.dart';

class AccessStatusCard extends StatelessWidget {
  final String status;
  final bool isGranted;

  const AccessStatusCard({
    super.key,
    required this.status,
    required this.isGranted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFE8D5C4),
            const Color(0xFFD4C4B0),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background geometric shapes
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -15,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          
          // Content
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.04,
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                Text(
                  status,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontWeight: FontWeight.w500,
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