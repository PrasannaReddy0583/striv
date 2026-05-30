import 'package:equatable/equatable.dart';

abstract class PitchUploadEvent extends Equatable {
  const PitchUploadEvent();
  @override
  List<Object?> get props => [];
}

class PitchStepChanged extends PitchUploadEvent {
  final int step;
  const PitchStepChanged(this.step);

  @override
  List<Object?> get props => [step];
}

class PitchStep1Saved extends PitchUploadEvent {
  final String problem;
  final String solution;
  final String keyDifferentiator;

  const PitchStep1Saved({
    required this.problem,
    required this.solution,
    required this.keyDifferentiator,
  });

  @override
  List<Object?> get props => [problem, solution, keyDifferentiator];
}

class PitchStep2Saved extends PitchUploadEvent {
  final String? videoPath;
  final List<String> imagePaths;

  const PitchStep2Saved({this.videoPath, this.imagePaths = const []});

  @override
  List<Object?> get props => [videoPath, imagePaths];
}

class PitchSubmitted extends PitchUploadEvent {
  const PitchSubmitted();
}

class PitchUploadReset extends PitchUploadEvent {
  const PitchUploadReset();
}
