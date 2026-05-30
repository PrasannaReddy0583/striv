// import 'package:flutter/material.dart';

// class DataRoomHeader extends StatelessWidget {
//   final String title;

//   const DataRoomHeader({
//     super.key,
//     required this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(
//         horizontal: MediaQuery.of(context).size.width * 0.04,
//         vertical: MediaQuery.of(context).size.height * 0.015,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           IconButton(
//             onPressed: () => Navigator.of(context).pop(),
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.black87,
//               size: MediaQuery.of(context).size.width * 0.06,
//             // ),
//             padding: EdgeInsets.zero,
//             constraints: const BoxConstraints(),
//           ),
//           SizedBox(width: MediaQuery.of(context).size.width * 0.04),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: MediaQuery.of(context).size.width * 0.045,
//               fontWeight: FontWeight.w600,
//               color: Colors.black87,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }