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
    on<LoadRecord>(_onLoadRecord);
    on<AddRecord>(_onAddRecord);
    on<UpdateRecord>(_onUpdateRecord);
    on<RecordsUpdated>(_onRecordsUpdated);
  }

  Future<void> _onLoadRecords(LoadRecords event, Emitter<RecordState> emit) async {
    try {
      await emit.forEach(
        recordRepository.getRecords(event.userId, event.date),
        onData: (List<DailyHealthRecord> records) {
          print("_onLoadRecords $records");
          return RecordLoaded(records);
        },
        onError: (error, stackTrace) {
          return RecordError(error.toString());
        },
      );
    } catch (error) {
      emit(RecordError(error.toString()));
    }
  }

  // Future<void> _onLoadRecords(LoadRecords event, Emitter<RecordState> emit) async {
  //   try {
  //     final records = await recordRepository.getRecords(event.userId, event.date);
  //     emit(RecordLoaded(records));
  //   } catch (error) {
  //     emit(RecordError(error.toString()));
  //   }
  // }

  Future<void> _onLoadRecord(LoadRecord event, Emitter<RecordState> emit) async {
    try {
      final record = await recordRepository.getRecordByDate(event.userId, event.date);
      if (record != null) {
        emit(SingleRecordLoaded(record));
      } else {
        emit(RecordNotFound());
      }
    } catch (e) {
      emit(const RecordError("Failed to load record"));
    }
  }

  Future<void> _onAddRecord(AddRecord event, Emitter<RecordState> emit) async {
    try {
      await recordRepository.addRecord(event.record);
      emit(RecordUpdated(event.record));
    } catch (e) {
      emit(const RecordError("Failed to add record"));
    }
  }

  Future<void> _onUpdateRecord(UpdateRecord event, Emitter<RecordState> emit) async {
    try {
      await recordRepository.updateRecord(event.record);
      emit(RecordUpdated(event.record));
    } catch (e) {
      emit(const RecordError("Failed to update record"));
    }
  }

  void _onRecordsUpdated(RecordsUpdated event, Emitter<RecordState> emit) {
    emit(RecordLoaded(event.records));
  }
}
