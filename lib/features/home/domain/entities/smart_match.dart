import 'package:equatable/equatable.dart';

class SmartMatch extends Equatable {
  final String id;
  final String name;
  final String role; // "Entrepreneur" | "Investor"
  final String avatarUrl;
  final int matchScore; // 0–100

  const SmartMatch({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarUrl,
    required this.matchScore,
  });

  @override
  List<Object?> get props => [id, name, role, avatarUrl, matchScore];
}
