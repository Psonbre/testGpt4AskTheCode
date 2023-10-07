import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:multiple_result/src/result.dart';
import 'package:revolvair/domain/failures/failure.dart';
import 'package:revolvair/domain/failures/location_disabled_failure.dart';
import 'package:revolvair/domain/failures/location_permission_denied_failure.dart';
import 'package:revolvair/domain/services/location_service.dart';

class LocationServiceImpl extends LocationService {
  @override
  Future<Result<Position, Failure>> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Error(
          LocationDisabledFailure(context: "Location service disabled"));
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Error(
          LocationPermissionFailure(context: "Permision denied by user"));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Error(
          LocationPermissionFailure(context: "Permision denied forever"));
    }

    Position currentPos = await Geolocator.getCurrentPosition();
    return Success(currentPos);
  }
}
