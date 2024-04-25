
import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  final String errorMsg;
  const CustomError({
    required this.errorMsg,
  });

@override
List<Object?> get props => [errorMsg];

@override
String toString() {
    return 'CustomError{errorMsg=$errorMsg}';
  }
}