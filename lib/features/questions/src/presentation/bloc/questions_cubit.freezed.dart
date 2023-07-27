// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'questions_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QuestionsState {
  List<Question> get questions => throw _privateConstructorUsedError;
  int get indice => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QuestionsStateCopyWith<QuestionsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionsStateCopyWith<$Res> {
  factory $QuestionsStateCopyWith(
          QuestionsState value, $Res Function(QuestionsState) then) =
      _$QuestionsStateCopyWithImpl<$Res, QuestionsState>;
  @useResult
  $Res call({List<Question> questions, int indice});
}

/// @nodoc
class _$QuestionsStateCopyWithImpl<$Res, $Val extends QuestionsState>
    implements $QuestionsStateCopyWith<$Res> {
  _$QuestionsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questions = null,
    Object? indice = null,
  }) {
    return _then(_value.copyWith(
      questions: null == questions
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Question>,
      indice: null == indice
          ? _value.indice
          : indice // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QuestionsStateCopyWith<$Res>
    implements $QuestionsStateCopyWith<$Res> {
  factory _$$_QuestionsStateCopyWith(
          _$_QuestionsState value, $Res Function(_$_QuestionsState) then) =
      __$$_QuestionsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Question> questions, int indice});
}

/// @nodoc
class __$$_QuestionsStateCopyWithImpl<$Res>
    extends _$QuestionsStateCopyWithImpl<$Res, _$_QuestionsState>
    implements _$$_QuestionsStateCopyWith<$Res> {
  __$$_QuestionsStateCopyWithImpl(
      _$_QuestionsState _value, $Res Function(_$_QuestionsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questions = null,
    Object? indice = null,
  }) {
    return _then(_$_QuestionsState(
      questions: null == questions
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Question>,
      indice: null == indice
          ? _value.indice
          : indice // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_QuestionsState implements _QuestionsState {
  const _$_QuestionsState(
      {required final List<Question> questions, required this.indice})
      : _questions = questions;

  final List<Question> _questions;
  @override
  List<Question> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  final int indice;

  @override
  String toString() {
    return 'QuestionsState(questions: $questions, indice: $indice)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QuestionsState &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions) &&
            (identical(other.indice, indice) || other.indice == indice));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_questions), indice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QuestionsStateCopyWith<_$_QuestionsState> get copyWith =>
      __$$_QuestionsStateCopyWithImpl<_$_QuestionsState>(this, _$identity);
}

abstract class _QuestionsState implements QuestionsState {
  const factory _QuestionsState(
      {required final List<Question> questions,
      required final int indice}) = _$_QuestionsState;

  @override
  List<Question> get questions;
  @override
  int get indice;
  @override
  @JsonKey(ignore: true)
  _$$_QuestionsStateCopyWith<_$_QuestionsState> get copyWith =>
      throw _privateConstructorUsedError;
}
