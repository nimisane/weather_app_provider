import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'temp_settings_state.dart';

enum TempUnit {
  celsius,
  fahrenheit,
}

class TempSettingState extends Equatable {
  const TempSettingState({required this.tempUnit});

  final TempUnit tempUnit;

  factory TempSettingState.initial() {
    return const TempSettingState(tempUnit: TempUnit.celsius);
  }

  @override
  List<Object> get props => [tempUnit];

  @override
  String toString() {
    return 'TempSettingState{tempUnit=$tempUnit}';
  }

  TempSettingState copyWith({TempUnit? tempUnit}) {
    return TempSettingState(tempUnit: tempUnit ?? this.tempUnit);
  }
}