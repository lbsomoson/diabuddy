part of 'record_bloc.dart';

abstract class RecordEvent extends Equatable {
  const RecordEvent();

  @override
  List<Object> get props => [];
}

class LoadRecords extends RecordEvent {
  final String userId;

  const LoadRecords(this.userId);

  @override
  List<Object> get props => [userId];
}

class AddRecord extends RecordEvent {
  final DailyHealthRecord record;

  const AddRecord(this.record);

  @override
  List<Object> get props => [record];
}

class UpdateRecord extends RecordEvent {
  final DailyHealthRecord record;

  const UpdateRecord(this.record);

  @override
  List<Object> get props => [record];
}

class DeleteRecord extends RecordEvent {
  final String recordId;

  const DeleteRecord(this.recordId);

  @override
  List<Object> get props => [recordId];
}

class RecordsUpdated extends RecordEvent {
  final List<DailyHealthRecord> records;

  const RecordsUpdated(this.records);

  @override
  List<Object> get props => [records];
}
