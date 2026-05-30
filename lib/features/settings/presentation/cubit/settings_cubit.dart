import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:striv/features/settings/presentation/cubit/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void toggleNotifications(bool value) =>
      emit(state.copyWith(notificationsEnabled: value));

  void toggleTwoFactor(bool value) =>
      emit(state.copyWith(twoFactorEnabled: value));

  void toggleDarkMode(bool value) => emit(state.copyWith(darkMode: value));
}
