enum TeamMembersSocialLinks { website, linkedin, twitter, youtube, instagram }

class TeamMember {
  final String name;
  final String role;
  final bool isVerified;
  final String description;
  final Map<TeamMembersSocialLinks, String> links;

  TeamMember({
    required this.name,
    required this.role,
    required this.isVerified,
    required this.description,
    required this.links,
  });
}
