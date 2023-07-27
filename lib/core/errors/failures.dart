import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Failure extends Equatable {
  final int? code;
  final String? title;
  final String? message;
  final Map<String, dynamic>? extraData;

  const Failure({
    this.code,
    this.title,
    this.message,
    this.extraData,
  });

  @override
  List<Object?> get props => [
        code,
        title,
        message,
        extraData,
      ];
}

/// This failure is usually used to things that fail on the Server Side
///
/// Example: When a request return something different than 20x
class ServerFailure extends Failure {
  const ServerFailure({
    int? code,
    String? title,
    String? message,
    Map<String, dynamic>? extraData,
  }) : super(
          code: code,
          title: title,
          message: message,
          extraData: extraData,
        );
}

class NotFoundFailure extends ServerFailure {
  const NotFoundFailure({
    String? message,
    Map<String, dynamic>? extraData,
  }) : super(
          code: 404,
          title: "notFound",
          message: message,
          extraData: extraData,
        );
}

class InternalServerFailure extends ServerFailure {
  const InternalServerFailure({
    String? message,
    Map<String, dynamic>? extraData,
  }) : super(
          code: 500,
          title: "internalServerFailure",
          message: message,
          extraData: extraData,
        );
}

class ForbiddenServerFailure extends ServerFailure {
  const ForbiddenServerFailure({
    String? message,
    Map<String, dynamic>? extraData,
  }) : super(
          code: 403,
          title: "forbiddenServerFailure",
          message: message,
          extraData: extraData,
        );
}

/// This failure is usually used to things related to the business logic of our product
///
/// Sometimes the API returns 200, but with the by corresponding to an error
class BusinessFailure extends Failure {
  const BusinessFailure({
    int? code,
    String? title,
    String? message,
    Map<String, dynamic>? extraData,
  }) : super(
          code: code,
          title: title,
          message: message,
          extraData: extraData,
        );
}

class MissingParamsFailure extends Failure {
  const MissingParamsFailure({
    int? code,
    String? title,
    String? message,
    Map<String, dynamic>? extraData,
  }) : super(
          code: code,
          title: title,
          message: message,
          extraData: extraData,
        );
}

/// This failure is usually used to things that fail on the Local Side
///
/// Example: Failed to get the current user logged on the app (which should be cached)
class LocalFailure extends Failure {
  const LocalFailure({
    int? code,
    String? title,
    String? message,
    Map<String, dynamic>? extraData,
  }) : super(
          code: code,
          title: title,
          message: message,
          extraData: extraData,
        );
}

class UnhandledFailure extends Failure {
  const UnhandledFailure({
    int? code = -1,
    String? title = 'Unhandled Failure',
    String? message,
    Map<String, dynamic>? extraData,
  }) : super(
          code: code,
          title: title,
          message: message,
          extraData: extraData,
        );
}

/// This failure is used for value objects
abstract class ValueFailure<T> extends Failure {
  T get failedValue;

  const ValueFailure({
    int? code,
    String? title,
    String? message,
  }) : super(code: code, title: title, message: message);
}

class InvalidParamsFailure extends Failure {
  const InvalidParamsFailure({
    int? code,
    String? title,
    String? message,
    Map<String, dynamic>? extraData,
  }) : super(
          code: code,
          title: title,
          message: message,
          extraData: extraData,
        );
}

class ForgotPasswordFailure extends Failure {
  const ForgotPasswordFailure() : super();
}

class WrongPasswordFailure extends Failure {
  final int remainingAttempts;

  const WrongPasswordFailure({
    required this.remainingAttempts,
  }) : super();

  @override
  List<Object?> get props => [
        ...super.props,
        remainingAttempts,
      ];
}

class UserLockedFailure extends Failure {
  final int blockTime;

  const UserLockedFailure({required this.blockTime}) : super();

  @override
  List<Object?> get props => [...super.props, blockTime];
}

class NoMoreDataToFetchFailure extends Failure {
  const NoMoreDataToFetchFailure({
    int? code,
    String? title,
    String? message,
    Map<String, dynamic>? extraData,
  }) : super(
          code: code,
          title: title,
          message: message,
          extraData: extraData,
        );
}

/// A connection failure happened.
///
/// Probably the app did not succeed to make a request
class ConnectionFailure extends Failure {}

class NullResponseFailure extends Failure {}

class TypeMismatchFailure extends Failure {
  const TypeMismatchFailure({
    required Type? runtimeTypeExpected,
    required Type? runtimeTypeFound,
  }) : super(
          message: "RuntimeType did not match expectations.\n"
              "Expected: $runtimeTypeExpected\n"
              "Found: $runtimeTypeFound",
        );
}

class AcronymNotFoundFailure extends Failure {}

class UserAcronymNotFoundFailure extends Failure {}

class LoginFailure extends Failure {}

class LoginUserNotAllowedFailure extends Failure {}

class ToManyResultsInSearchFailure extends Failure {}

class AtLeastOneDataFailure extends Failure {}

class RepeatedSubscriptionAttemptFailure extends Failure {}

class SimultaneousSubscriptionAttemptFailure extends Failure {}

class UserNotAllowedToSignBatchesOrSheetsFailure extends Failure {}

class SimultaneousCancellationAttemptFailure extends Failure {}

class InvalidSignatureNumberFailure extends Failure {}

class UserWithoutPermissionFailure extends Failure {}

class InvalidStatusFailure extends Failure {}

class NotAllowedJurisdictionFailure extends Failure {}

class NotAllowedCutOffTimeFailure extends Failure {}

class ParametersNotFoundDatabaseFailure extends Failure {}

class ThereAreNoRegisteredPayersForUserFailure extends Failure {}

class PaymentSignatureNotAllowedForPaymentBatchFailure extends Failure {}
