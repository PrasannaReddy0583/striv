import 'package:flutter/material.dart';

Widget buildPasswordRule(String text, bool isValid) {
  return Row(
    children: [
      Icon(
        isValid ? Icons.check_circle : Icons.cancel,
        size: 18,
        color: isValid ? Colors.black : Colors.grey,
      ),
      const SizedBox(width: 8),
      Text(
        text,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          color: isValid ? Colors.black : Colors.black54,
        ),
      ),
    ],
  );
}
