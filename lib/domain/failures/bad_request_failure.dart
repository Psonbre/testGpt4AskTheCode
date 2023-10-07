import 'failure.dart';

class BadRequestFailure extends Failure {
  BadRequestFailure({super.context}) : super(message: 'Bad Request');
}