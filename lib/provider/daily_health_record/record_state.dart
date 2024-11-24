part of 'record_bloc.dart';

abstract class RecordState extends Equatable {
  const RecordState();

  @override
  List<Object> get props => [];
}

class RecordLoading extends RecordState {}

class RecordLoaded extends RecordState {
  final List<DailyHealthRecord> records;

  const RecordLoaded(this.records);

  @override
  List<Object> get props => [records];
}

class RecordError extends RecordState {
  final String message;

  const RecordError(this.message);

  @override
  List<Object> get props => [message];
}
