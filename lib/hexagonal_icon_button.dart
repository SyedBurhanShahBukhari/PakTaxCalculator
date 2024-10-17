import 'package:flutter/material.dart';

class HexagonalIconButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;
  final VoidCallback onPressed;

  const HexagonalIconButton({
    Key? key,
    required this.icon,
    required this.size,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle, // This will create a circular background; adjust to hexagon if needed
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: size * 0.5,
          ),
        ),
      ),
    );
  }
}
