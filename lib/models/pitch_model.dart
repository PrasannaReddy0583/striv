class PitchModel {
  final String pitchid;
  final String companyName;
  final String tagline;
  final String videoUrl;
  final String problem;
  final String solution;
  final String differentiator;
  final List<String> tabs;
  final int selectedTabIndex;

  PitchModel({
    required this.pitchid,
    required this.companyName,
    required this.tagline,
    required this.videoUrl,
    required this.problem,
    required this.solution,
    required this.differentiator,
    required this.tabs,
    this.selectedTabIndex = 0,
  });

  PitchModel copyWith({
    String? companyName,
    String? tagline,
    String? videoUrl,
    String? problem,
    String? solution,
    String? differentiator,
    List<String>? tabs,
    int? selectedTabIndex,
  }) {
    return PitchModel(
      pitchid: pitchid,
      companyName: companyName ?? this.companyName,
      tagline: tagline ?? this.tagline,
      videoUrl: videoUrl ?? this.videoUrl,
      problem: problem ?? this.problem,
      solution: solution ?? this.solution,
      differentiator: differentiator ?? this.differentiator,
      tabs: tabs ?? this.tabs,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }
}
