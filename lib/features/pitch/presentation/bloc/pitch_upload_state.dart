import 'package:equatable/equatable.dart';

class PitchUploadState extends Equatable {
  final int currentStep;
  final String problem;
  final String solution;
  final String keyDifferentiator;
  final String? videoPath;
  final List<String> imagePaths;
  final bool isSubmitting;
  final bool isSubmitted;
  final String? errorMessage;

  const PitchUploadState({
    this.currentStep = 0,
    this.problem = '',
    this.solution = '',
    this.keyDifferentiator = '',
    this.videoPath,
    this.imagePaths = const [],
    this.isSubmitting = false,
    this.isSubmitted = false,
    this.errorMessage,
  });

  PitchUploadState copyWith({
    int? currentStep,
    String? problem,
    String? solution,
    String? keyDifferentiator,
    String? videoPath,
    List<String>? imagePaths,
    bool? isSubmitting,
    bool? isSubmitted,
    String? errorMessage,
  }) =>
      PitchUploadState(
        currentStep: currentStep ?? this.currentStep,
        problem: problem ?? this.problem,
        solution: solution ?? this.solution,
        keyDifferentiator: keyDifferentiator ?? this.keyDifferentiator,
        videoPath: videoPath ?? this.videoPath,
        imagePaths: imagePaths ?? this.imagePaths,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSubmitted: isSubmitted ?? this.isSubmitted,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [
        currentStep,
        problem,
        solution,
        keyDifferentiator,
        videoPath,
        imagePaths,
        isSubmitting,
        isSubmitted,
        errorMessage,
      ];
}
