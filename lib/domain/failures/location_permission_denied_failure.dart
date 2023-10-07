import 'package:revolvair/domain/failures/failure.dart';

class LocationPermissionFailure extends Failure {
  LocationPermissionFailure({super.context}) : super(message: 'Location permission doesnt allow to continue');
}