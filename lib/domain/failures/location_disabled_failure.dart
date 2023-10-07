import 'package:revolvair/domain/failures/failure.dart';

class LocationDisabledFailure extends Failure {
  LocationDisabledFailure({super.context}) : super(message: 'Location service disabled');
}