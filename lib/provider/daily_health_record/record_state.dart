part of 'record_bloc.dart';

abstract class RecordState extends Equatable {
  const RecordState();

  @override
  List<Object> get props => [];
}

class RecordNotFound extends RecordState {}

class RecordLoading extends RecordState {}

class RecordLoaded extends RecordState {
  final List<DailyHealthRecord> records;

  const RecordLoaded(this.records);

  @override
  List<Object> get props => [records];
}

class SingleRecordLoaded extends RecordState {
  final DailyHealthRecord record;

  const SingleRecordLoaded(this.record);

  @override
  List<Object> get props => [record];
}

class RecordError extends RecordState {
  final String message;

  const RecordError(this.message);

  @override
  List<Object> get props => [message];
}
