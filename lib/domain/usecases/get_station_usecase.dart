import 'package:multiple_result/multiple_result.dart';
import 'package:revolvair/domain/entities/station.dart';
import 'package:revolvair/domain/failures/failure.dart';
import 'package:revolvair/domain/services/station_service.dart';

class GetStationUseCase {
  final StationService stationService;

  GetStationUseCase({required this.stationService});

  Future<Result<List<Station>, Failure>> execute() {
    return stationService.getAllStations();
  }
}
