import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// This exception is usually used to things that fail on the Server Side
///
/// Example: When a request return something different than 20x

import 'failures.dart';

abstract class AppException extends Equatable implements Exception {
  final int? code;
  final String? title;
  final String? message;
  final Map<String, dynamic>? extraData;

  const AppException({
    this.code,
    this.message,
    this.title,
    this.extraData,
  });

  @override
  String toString() {
    return 'code: $code;\ntitle: $title;\nmessage: $message;\nextraData: $extraData;';
  }

  Failure toFailure();

  @override
  List<Object?> get props => [code, title, message, extraData];
}

/// This exception is usually used to things that fail on the Server Side
///
/// Example: When a request return something different than 20x
class ServerException extends AppException {
  const ServerException({
    int? code,
    String? message,
    String? title,
    Map<String, dynamic>? extraData,
  }) : super(
          code: code,
          message: message,
          title: title,
          extraData: extraData,
        );

  @override
  ServerFailure toFailure() => ServerFailure(
        code: code,
        message: message,
        title: title,
        extraData: extraData,
      );
}

class ForbiddenServerException extends ServerException {
  const ForbiddenServerException({
    String? message,
    Map<String, dynamic>? extraData,
  }) : super(
          code: 403,
          title: "forbiddenServerException",
          message: message,
          extraData: extraData,
        );

  @override
  ForbiddenServerFailure toFailure() => ForbiddenServerFailure(
        message: message,
        extraData: extraData,
      );
}

class InternalServerException extends ServerException {
  const InternalServerException({
    String? message,
    Map<String, dynamic>? extraData,
  }) : super(
          code: 500,
          title: "internalServerException",
          message: message,
          extraData: extraData,
        );

  @override
  InternalServerFailure toFailure() => InternalServerFailure(
        message: message,
        extraData: extraData,
      );
}

class NotFoundException extends AppException {
  const NotFoundException({
    int? code,
    String? message,
    String? title,
    Map<String, dynamic>? extraData,
  }) : super(
          code: code,
          message: message,
          title: title,
          extraData: extraData,
        );

  @override
  NotFoundFailure toFailure() => NotFoundFailure(
        message: message,
        extraData: extraData,
      );
}

/// This exception is usually used to things related to the business logic of our product
///
/// Sometimes the API returns 200, but with the by corresponding to an error
class BusinessException extends AppException {
  const BusinessException({
    int? code,
    String? message,
    String? title,
    Map<String, dynamic>? extraData,
  }) : super(
          code: code,
          message: message,
          title: title,
          extraData: extraData,
        );

  @override
  BusinessFailure toFailure() => BusinessFailure(
        message: message,
        extraData: extraData,
      );
}

/// This exception is usually used to things that fail on the Local Side
///
/// Example: Failed to get the current user logged on the app (which should be cached)
/// Example: When there is something wrong on the SharedPrefferences/FlutterSecureStorage
class LocalException extends AppException {
  const LocalException({
    int? code,
    String? message,
    String? title,
    Map<String, dynamic>? extraData,
  }) : super(
          code: code,
          message: message,
          title: title,
          extraData: extraData,
        );

  @override
  LocalFailure toFailure() => LocalFailure(
        code: code,
        message: message,
        title: title,
        extraData: extraData,
      );
}

@immutable
class UnhandledException extends AppException {
  const UnhandledException(String message) : super(message: message);

  @override
  UnhandledFailure toFailure() => UnhandledFailure(
        code: code,
        message: message,
        title: title,
        extraData: extraData,
      );
}

@immutable
class MissingParamsException implements Exception {
  final String? message;

  const MissingParamsException({this.message});
}

/// A connection exception happened.
///
/// Probably the app did not succeed to make a request
@immutable
class ConnectionException extends AppException {
  @override
  Failure toFailure() {
    return ConnectionFailure();
  }
}

class NullResponseException extends AppException {
  const NullResponseException({
    int? code,
    String? message,
    String? title,
    Map<String, dynamic>? extraData,
  }) : super(
          code: code,
          message: message,
          title: title,
          extraData: extraData,
        );

  @override
  NullResponseFailure toFailure() => NullResponseFailure();
}

class InvalidParamsException extends AppException {
  const InvalidParamsException({
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

  @override
  InvalidParamsFailure toFailure() => InvalidParamsFailure(
        code: code,
        message: message,
        title: title,
        extraData: extraData,
      );
}

class TypeMismatchException extends AppException {
  final Type? runtimeTypeExpected;
  final Type? runtimeTypeFound;

  const TypeMismatchException({
    required this.runtimeTypeExpected,
    required this.runtimeTypeFound,
  }) : super(
          message: "RuntimeType did not match expectations.\n"
              "Expected: $runtimeTypeExpected\n"
              "Found: $runtimeTypeFound",
        );

  @override
  Failure toFailure() {
    return TypeMismatchFailure(
      runtimeTypeExpected: runtimeTypeExpected,
      runtimeTypeFound: runtimeTypeFound,
    );
  }
}

class ForgotPasswordException extends AppException {
  const ForgotPasswordException({
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

  @override
  Failure toFailure() => const ForgotPasswordFailure();
}

class WrongPasswordException extends AppException {
  static const errorCode = 492;

  final int remainingAttempts;

  const WrongPasswordException({
    required this.remainingAttempts,
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

  @override
  Failure toFailure() => WrongPasswordFailure(
        remainingAttempts: remainingAttempts,
      );
}

class UserLockedException extends AppException {
  static const errorCode = 493;
  final int blockTime;

  const UserLockedException({
    required this.blockTime,
    String? title,
    String? message,
    Map<String, dynamic>? extraData,
  }) : super(
          code: errorCode,
          title: title,
          message: message,
          extraData: extraData,
        );

  @override
  Failure toFailure() => UserLockedFailure(blockTime: blockTime);

  @override
  List<Object?> get props => [...super.props, blockTime];
}

class AcronymNotFoundException extends AppException {
  static const messageError = 'SIGLA não encontrada!';

  const AcronymNotFoundException({
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

  @override
  Failure toFailure() => AcronymNotFoundFailure();
}

class UserAcronymNotFoundException extends AppException {
  static const messageError = 'não encontrado para SIGLA informada!';

  const UserAcronymNotFoundException({
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

  @override
  Failure toFailure() => AcronymNotFoundFailure();
}

class LoginError extends AppException {
  final List<String> errorCodes = const [
    'USR-01',
    'USR-02',
    'USR-03',
    'USR-04',
    'USR-05',
    'USR-07',
    'USR-12',
  ];

  const LoginError({
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

  @override
  Failure toFailure() => LoginFailure();
}

class LoginUserNotAllowedError extends AppException {
  final List<String> errorCodes = const [
    'USR-06',
  ];

  const LoginUserNotAllowedError({
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

  @override
  Failure toFailure() => LoginUserNotAllowedFailure();
}
// USR01("USR-01", "Sigla não existe", HttpStatus.BAD_REQUEST),
// USR02("USR-02", "Usuário não encontrado para sigla", HttpStatus.BAD_REQUEST),
// USR03("USR-03", "Senha inválida", HttpStatus.BAD_REQUEST),
// USR04("USR-04", "Senha expirada", HttpStatus.UNAUTHORIZED),
// USR05("USR-05", "Senha incorreta", HttpStatus.BAD_REQUEST),
// USR06("USR-06", "Usuário sem perfil de acesso", HttpStatus.FORBIDDEN),
// USR07("USR-07", "Usuário bloqueado", HttpStatus.UNAUTHORIZED),
// USR08("USR-08", "header username is required", HttpStatus.BAD_REQUEST),
// USR09("USR-09", "header sigla is required", HttpStatus.BAD_REQUEST),
// USR10("USR-10", "header Authorization is required", HttpStatus.BAD_REQUEST),
// USR11("USR-11", "user session expired", HttpStatus.UNAUTHORIZED),
// USR12("USR-12", "user não existe no keycloak", HttpStatus.UNAUTHORIZED);


class ToManyResultsInSearchError extends AppException {
  final List<String> errorCodes = const [
    'PAG-01',
  ];

  const ToManyResultsInSearchError({
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

  @override
  Failure toFailure() => ToManyResultsInSearchFailure();
}

class AtLeastOneDataError extends AppException {
  final List<String> errorCodes = const [
    'PAG-02',
  ];

  const AtLeastOneDataError({
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

  @override
  Failure toFailure() => AtLeastOneDataFailure();
}

class RepeatedSubscriptionAttemptError extends AppException {
  final List<String> errorCodes = const [
    'PAG-03',
  ];

  const RepeatedSubscriptionAttemptError({
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

  @override
  Failure toFailure() => RepeatedSubscriptionAttemptFailure();
}

class SimultaneousSubscriptionAttemptError extends AppException {
  final List<String> errorCodes = const [
    'PAG-04',
  ];

  const SimultaneousSubscriptionAttemptError({
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

  @override
  Failure toFailure() => SimultaneousSubscriptionAttemptFailure();
}

class UserNotAllowedToSignBatchesOrSheetsError extends AppException {
  final List<String> errorCodes = const [
    'PAG-05',
  ];

  const UserNotAllowedToSignBatchesOrSheetsError({
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

  @override
  Failure toFailure() => UserNotAllowedToSignBatchesOrSheetsFailure();
}

class SimultaneousCancellationAttemptError extends AppException {
  final List<String> errorCodes = const [
    'PAG-06',
  ];

  const SimultaneousCancellationAttemptError({
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

  @override
  Failure toFailure() => SimultaneousCancellationAttemptFailure();
}

class InvalidSignatureNumberError extends AppException {
  final List<String> errorCodes = const [
    'PAG-07',
  ];

  const InvalidSignatureNumberError({
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

  @override
  Failure toFailure() => InvalidSignatureNumberFailure();
}

class UserWithoutPermissionError extends AppException {
  final List<String> errorCodes = const [
    'PAG-08',
  ];

  const UserWithoutPermissionError({
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

  @override
  Failure toFailure() => UserWithoutPermissionFailure();
}

class InvalidStatusError extends AppException {
  final List<String> errorCodes = const [
    'PAG-09',
  ];

  const InvalidStatusError({
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

  @override
  Failure toFailure() => InvalidStatusFailure();
}

class NotAllowedJurisdictionError extends AppException {
  final List<String> errorCodes = const [
    'PAG-10',
  ];

  const NotAllowedJurisdictionError({
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

  @override
  Failure toFailure() => NotAllowedJurisdictionFailure();
}

class NotAllowedCutOffTimeError extends AppException {
  final List<String> errorCodes = const [
    'PAG-11',
  ];

  const NotAllowedCutOffTimeError({
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

  @override
  Failure toFailure() => NotAllowedCutOffTimeFailure();
}

class ParametersNotFoundDatabaseError extends AppException {
  final List<String> errorCodes = const [
    'PAG-12',
  ];

  const ParametersNotFoundDatabaseError({
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

  @override
  Failure toFailure() => ParametersNotFoundDatabaseFailure();
}

class ThereAreNoRegisteredPayersForUserError extends AppException {
  final List<String> errorCodes = const [
    'PAG-13',
  ];

  const ThereAreNoRegisteredPayersForUserError({
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

  @override
  Failure toFailure() => ThereAreNoRegisteredPayersForUserFailure();
}

class PaymentSignatureNotAllowedForPaymentBatchError extends AppException {
  final List<String> errorCodes = const [
    'PAG-14',
  ];

  const PaymentSignatureNotAllowedForPaymentBatchError({
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

  @override
  Failure toFailure() => PaymentSignatureNotAllowedForPaymentBatchFailure();
}
