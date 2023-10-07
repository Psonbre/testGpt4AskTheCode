import 'failure.dart';

class ServerFailure extends Failure {
  ServerFailure({super.context}) : super(message: 'Server error');
}
