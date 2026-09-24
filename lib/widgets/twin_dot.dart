import 'package:flutter/material.dart';
import '../themes/app_colors.dart';


class TwinDot extends StatelessWidget {
  const TwinDot({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 20,
      height: 12,
      child: Stack(
        children: [
          Positioned(left: 0, child: _Dot(color: AppColors.teal)),
          Positioned(left: 8, child: _Dot(color: AppColors.orange)),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;

  const _Dot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1),
      ),
    );
  }
}
