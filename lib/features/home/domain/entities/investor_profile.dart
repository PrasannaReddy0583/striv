import 'package:equatable/equatable.dart';

class InvestorProfile extends Equatable {
  final String id;
  final String name;
  final String role;
  final String avatarUrl;
  final List<String> focusAreas;

  const InvestorProfile({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarUrl,
    this.focusAreas = const [],
  });

  @override
  List<Object?> get props => [id, name, role, avatarUrl, focusAreas];
}
