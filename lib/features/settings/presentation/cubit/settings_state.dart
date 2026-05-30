import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final bool notificationsEnabled;
  final bool twoFactorEnabled;
  final bool darkMode;

  const SettingsState({
    this.notificationsEnabled = true,
    this.twoFactorEnabled = false,
    this.darkMode = false,
  });

  SettingsState copyWith({
    bool? notificationsEnabled,
    bool? twoFactorEnabled,
    bool? darkMode,
  }) =>
      SettingsState(
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
        twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
        darkMode: darkMode ?? this.darkMode,
      );

  @override
  List<Object?> get props =>
      [notificationsEnabled, twoFactorEnabled, darkMode];
}
