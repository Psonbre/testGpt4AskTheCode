import 'package:multiple_result/multiple_result.dart';
import 'package:revolvair/domain/entities/station.dart';
import 'package:revolvair/domain/failures/failure.dart';

abstract class StationService {
  Future<Result<List<Station>, Failure>> getAllStations();
}
