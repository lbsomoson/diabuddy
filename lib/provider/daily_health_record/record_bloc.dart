import 'package:diabuddy/models/daily_health_record_model.dart';
import 'package:diabuddy/provider/daily_health_record/record_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'record_event.dart';
part 'record_state.dart';

class RecordBloc extends Bloc<RecordEvent, RecordState> {
  final RecordRepository recordRepository;

  RecordBloc(this.recordRepository) : super(RecordLoading()) {
    on<LoadRecords>(_onLoadRecords);
    on<AddRecord>(_onAddRecord);
    on<UpdateRecord>(_onUpdateRecord);
    on<DeleteRecord>(_onDeleteRecord);
    on<RecordsUpdated>(_onRecordsUpdated);
  }

  Future<void> _onLoadRecords(LoadRecords event, Emitter<RecordState> emit) async {
    recordRepository.getRecords(event.userId).listen((records) {
      add(RecordsUpdated(records));
    });
  }

  Future<void> _onAddRecord(AddRecord event, Emitter<RecordState> emit) async {
    await recordRepository.addRecord(event.record);
  }

  Future<void> _onUpdateRecord(UpdateRecord event, Emitter<RecordState> emit) async {
    await recordRepository.updateRecord(event.record);
  }

  Future<void> _onDeleteRecord(DeleteRecord event, Emitter<RecordState> emit) async {
    await recordRepository.deleteRecord(event.recordId);
  }

  void _onRecordsUpdated(RecordsUpdated event, Emitter<RecordState> emit) {
    emit(RecordLoaded(event.records));
  }
}
