import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:striv/features/pitch/presentation/bloc/pitch_upload_event.dart';
import 'package:striv/features/pitch/presentation/bloc/pitch_upload_state.dart';

class PitchUploadBloc extends Bloc<PitchUploadEvent, PitchUploadState> {
  PitchUploadBloc() : super(const PitchUploadState()) {
    on<PitchStepChanged>(_onStepChanged);
    on<PitchStep1Saved>(_onStep1Saved);
    on<PitchStep2Saved>(_onStep2Saved);
    on<PitchSubmitted>(_onSubmit);
    on<PitchUploadReset>(_onReset);
  }

  void _onStepChanged(PitchStepChanged event, Emitter<PitchUploadState> emit) {
    emit(state.copyWith(currentStep: event.step));
  }

  void _onStep1Saved(PitchStep1Saved event, Emitter<PitchUploadState> emit) {
    emit(state.copyWith(
      problem: event.problem,
      solution: event.solution,
      keyDifferentiator: event.keyDifferentiator,
      currentStep: 1,
    ));
  }

  void _onStep2Saved(PitchStep2Saved event, Emitter<PitchUploadState> emit) {
    emit(state.copyWith(
      videoPath: event.videoPath,
      imagePaths: event.imagePaths,
      currentStep: 2,
    ));
  }

  Future<void> _onSubmit(
    PitchSubmitted event,
    Emitter<PitchUploadState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true));
    try {
      // TODO: call PitchRepository.submitPitch() once backend is ready
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(isSubmitting: false, isSubmitted: true));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, errorMessage: e.toString()));
    }
  }

  void _onReset(PitchUploadReset event, Emitter<PitchUploadState> emit) {
    emit(const PitchUploadState());
  }
}
