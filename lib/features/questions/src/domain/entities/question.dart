import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String question;
  final bool? answer;

  const Question({
    required this.question,
    this.answer,
  });

  @override
  List<Object?> get props => [
        question,
        answer,
      ];
}
