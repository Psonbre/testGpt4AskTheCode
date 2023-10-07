import 'package:geolocator/geolocator.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:revolvair/domain/failures/failure.dart';

abstract class LocationService{
  Future<Result<Position, Failure>> getCurrentPosition();
}