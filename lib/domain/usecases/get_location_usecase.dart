import 'package:geolocator/geolocator.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:revolvair/domain/failures/failure.dart';
import 'package:revolvair/domain/services/location_service.dart';

class GetLocationUseCase {
  final LocationService locationService;

  GetLocationUseCase({required this.locationService});

  Future<Result<Position, Failure>> execute() {
    return locationService.getCurrentPosition();
  }
}
