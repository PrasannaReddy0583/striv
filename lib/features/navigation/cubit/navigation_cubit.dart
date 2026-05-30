import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:striv/features/navigation/cubit/navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  void navigateTo(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
