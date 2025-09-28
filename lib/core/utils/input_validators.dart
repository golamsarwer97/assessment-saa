import '../errors/failures.dart';
import 'package:dartz/dartz.dart';

class InputValidators {
  static Either<Failure, String> validateEmail(String email) {
    if (email.isEmpty) {
      return Left(ValidationFailure('Email is required'));
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return Left(ValidationFailure('Please enter a valid email address'));
    }

    return Right(email);
  }

  static Either<Failure, String> validatePassword(String password) {
    if (password.isEmpty) {
      return Left(ValidationFailure('Password is required'));
    }

    if (password.length < 6) {
      return Left(ValidationFailure('Password must be at least 6 characters'));
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      return Left(ValidationFailure('Password must contain at least one number'));
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      return Left(ValidationFailure('Password must contain at least one uppercase letter'));
    }

    return Right(password);
  }
}
