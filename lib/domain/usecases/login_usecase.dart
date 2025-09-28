import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/input_validators.dart';

class LoginUseCase {
  Either<Failure, bool> execute(String email, String password) {
    final emailValidation = InputValidators.validateEmail(email);
    final passwordValidation = InputValidators.validatePassword(password);

    return emailValidation.fold(
      (emailFailure) => Left(emailFailure),
      (_) => passwordValidation.fold(
        (passwordFailure) => Left(passwordFailure),
        (_) => Right(true),
      ),
    );
  }
}
