import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:striv/features/community/presentation/cubit/community_state.dart';

class CommunityCubit extends Cubit<CommunityState> {
  CommunityCubit() : super(const CommunityInitial());

  Future<void> load() async {
    emit(const CommunityLoaded());
  }
}
