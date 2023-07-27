part of 'questions_cubit.dart';

@freezed
abstract class QuestionsState with _$QuestionsState {
  const factory QuestionsState({
    required List<Question> questions,
    required int indice,
  }) = _QuestionsState;
}

