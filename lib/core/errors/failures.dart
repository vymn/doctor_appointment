import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  final String message;
  const Failures({required this.message});
  @override
  List<Object> get props => [message];
}

class NetworkFailure extends Failures {
  @override
  final String message;
  const NetworkFailure({required this.message}) : super(message: message);
}

class DatabaseFailure extends Failures {
  @override
  final String message;
  const DatabaseFailure({required this.message}) : super(message: message);
}

class TimeoutFailure extends Failures {
  const TimeoutFailure() : super(message: 'Request timed out');
}
