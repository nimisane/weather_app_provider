import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_provider/constants/constants.dart';
import 'package:weather_app_provider/providers/weather/weather_provider.dart';

part 'change_theme_state.dart';

enum AppTheme {
  light,
  dark,
}

class ChangeThemeState extends Equatable {
  const ChangeThemeState({required this.appTheme});

  final AppTheme appTheme;

  factory ChangeThemeState.initial() {
    return const ChangeThemeState(appTheme: AppTheme.light);
  }

  @override
  List<Object> get props => [appTheme];

  @override
  String toString() {
    return 'ChangeThemeState{appTheme=$appTheme}';
  }

  ChangeThemeState copyWith({AppTheme? appTheme}) {
    return ChangeThemeState(appTheme: appTheme ?? this.appTheme);
  }
}