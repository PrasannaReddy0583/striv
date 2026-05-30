import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;

  const ActionButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = Colors.orange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.065,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.04,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}