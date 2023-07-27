import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fale_baby_app/features/questions/src/domain/entities/question.dart';

part 'questions_state.dart';
part 'questions_cubit.freezed.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  QuestionsCubit()
      : super(const QuestionsState(
          questions: [],
          indice: 0,
        ));

  answer({
    required bool answer,
  }) {
  }

  back() {}
}

