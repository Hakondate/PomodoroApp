//import 'package:drift/drift.dart' hide JsonKey;
import 'package:freezed_annotation/freezed_annotation.dart';
part 'task_model.freezed.dart';

@freezed
abstract class TaskModel with _$TaskModel {
  const factory TaskModel({
    //id
    required int id,
    //タイトル
    required String title,
    //ジャンル
    //required int  genre,
    //完了状態
    required bool isCompleted,
  }) = _TaskModel;
}
